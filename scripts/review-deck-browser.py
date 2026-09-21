#!/usr/bin/env python3
"""Capture the main route and report layout/network issues for visual review."""

import argparse
import json
from pathlib import Path
import shutil
from urllib.parse import urlsplit

from playwright.sync_api import sync_playwright


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--url', default='http://127.0.0.1:8877/')
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--browser', default=shutil.which('google-chrome'))
    parser.add_argument('--offline', action='store_true', help='Block non-local HTTP requests.')
    parser.add_argument('--include-backup', action='store_true')
    args = parser.parse_args()
    if not args.browser:
        parser.error('system Chrome not found; pass --browser')
    args.output.mkdir(parents=True, exist_ok=True)
    base = args.url.rstrip('/') + '/'
    origin = urlsplit(base).netloc
    report = {'url': base, 'offline': args.offline, 'slides': [],
              'errors': [], 'httpErrors': [], 'externalRequests': []}
    with sync_playwright() as p:
        browser = p.chromium.launch(executable_path=args.browser, args=['--no-sandbox'])
        context = browser.new_context(viewport={'width': 1280, 'height': 720})

        def route_request(route):
            url = urlsplit(route.request.url)
            external = url.scheme in ('http', 'https') and url.netloc != origin
            if external:
                report['externalRequests'].append(route.request.url)
            if external and args.offline:
                route.abort()
            else:
                route.continue_()

        context.route('**/*', route_request)
        page = context.new_page()
        page.on('pageerror', lambda error: report['errors'].append(str(error)))
        page.on('response', lambda response: report['httpErrors'].append(
            {'status': response.status, 'url': response.url}) if response.status >= 400 else None)
        page.goto(base)
        page.locator('section.title-slide.present').wait_for()
        slides = page.evaluate('''() => {
            const result = [];
            [...document.querySelectorAll('.reveal .slides > section')].forEach((top, h) => {
                const children = [...top.querySelectorAll(':scope > section')];
                (children.length ? children : [top]).forEach((section, v) => {
                    result.push({h, v, title: section.querySelector('h1, h2, h3')?.textContent.trim()});
                });
            });
            return result;
        }''')
        for entry in slides:
            if entry['h'] >= 6 and not args.include_backup:
                continue
            route = '#/' + str(entry['h']) + '/' + str(entry['v'])
            page.goto(base + route)
            slide = page.locator('section.present:not(.stack)')
            slide.get_by_role('heading', name=entry['title'], exact=True).wait_for()
            page.wait_for_timeout(1000)
            entry['graphs'] = slide.locator('[data-bp-slide-graph]').evaluate_all('''hosts =>
                hosts.map(host => ({status: host.dataset.bpGraphStatus || 'uninitialized'}))''')
            entry['overflow'] = slide.evaluate('''(slide) => {
                const bounds = slide.getBoundingClientRect();
                return [...slide.querySelectorAll('h1, h2, h3, p, pre, iframe, img')]
                    .filter(e => !e.closest('aside.notes, .bp_relation_panel, .bp_graph_preview'))
                    .filter(e => e.getBoundingClientRect().width && e.getBoundingClientRect().height)
                    .filter(e => {
                        const r = e.getBoundingClientRect();
                        return r.right > bounds.right + 2 || r.bottom > bounds.bottom + 2 ||
                            r.left < bounds.left - 2 || r.top < bounds.top - 2;
                    }).map(e => ({tag: e.tagName, text: e.textContent.trim().slice(0, 120)}));
            }''')
            entry['screenshot'] = f"slide-{entry['h']}-{entry['v']}.png"
            page.screenshot(path=str(args.output / entry['screenshot']))
            report['slides'].append(entry)
        browser.close()
    report['externalRequests'] = sorted(set(report['externalRequests']))
    (args.output / 'review.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report, indent=2))
    return int(bool(report['errors'] or report['httpErrors'] or
                    (args.offline and report['externalRequests']) or
                    any(slide['overflow'] or any(graph['status'] != 'ready'
                        for graph in slide['graphs']) for slide in report['slides'])))


if __name__ == '__main__':
    raise SystemExit(main())
