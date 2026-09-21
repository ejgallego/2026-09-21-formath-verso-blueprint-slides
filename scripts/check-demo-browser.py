#!/usr/bin/env python3
"""Rehearse the talk's local browser interactions with system Chrome."""

import argparse
from pathlib import Path
import shutil

from playwright.sync_api import sync_playwright


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--url', default='http://127.0.0.1:8877/')
    parser.add_argument('--browser', default=shutil.which('google-chrome'))
    parser.add_argument('--screenshots', type=Path)
    args = parser.parse_args()
    if not args.browser:
        parser.error('system Chrome not found; pass --browser /path/to/chrome')
    base = args.url.rstrip('/') + '/'
    if args.screenshots:
        args.screenshots.mkdir(parents=True, exist_ok=True)

    with sync_playwright() as p:
        browser = p.chromium.launch(executable_path=args.browser, args=['--no-sandbox'])
        page = browser.new_page(viewport={'width': 1280, 'height': 720})
        errors = []
        page.on('pageerror', lambda error: errors.append(str(error)))

        def capture(name):
            if args.screenshots:
                page.screenshot(path=str(args.screenshots / (name + '.png')))

        page.goto(base + '#/0')
        title = page.locator('section.title-slide.present')
        title.wait_for()
        metadata = title.locator('.meta').inner_text()
        assert 'ForMath Seminar, IRIF, Université Paris Cité' in metadata
        assert 'Monday, 21 September 2026' in metadata
        speaker = title.get_by_role('link', name='Emilio Jesús Gallego Arias', exact=True)
        assert speaker.evaluate('(e) => getComputedStyle(e).color') == 'rgb(255, 255, 255)'
        page.wait_for_timeout(1000)
        capture('title')
        print('PASS: confirmed event metadata and speaker-link contrast')

        # Opening: three substantive slides, sources in notes, no text overflow.
        for route, title, evidence in [
            ('#/1', 'FLT: A Shared Mathematical Plan', 'Prove2Me'),
            ('#/1/1', 'Navier–Stokes: Scope And Understanding', 'C and D'),
            ('#/1/2', 'Blueprints Before And After Formalization', 'Before'),
        ]:
            page.goto(base + route)
            slide = page.locator('section.present:not(.stack)')
            slide.get_by_role('heading', name=title, exact=True).wait_for()
            slide.get_by_text(evidence, exact=True).wait_for()
            page.wait_for_timeout(1000)
            assert slide.evaluate('''(slide) => {
                const bounds = slide.getBoundingClientRect();
                return [...slide.querySelectorAll('h2, h3, p, li')]
                    .filter(e => !e.closest('aside.notes'))
                    .every(e => {
                        const r = e.getBoundingClientRect();
                        return r.right <= bounds.right + 2 &&
                            r.bottom <= bounds.bottom + 2 &&
                            e.scrollWidth <= e.clientWidth + 2;
                    });
            }'''), 'opening text overflows: ' + title
            capture('opening' + route.removeprefix('#').replace('/', '-'))
        print('PASS: opening claims and text bounds')

        # Verso: authored reference and live declaration information.
        page.goto(base + 'demo/verso/Applying-a-function/')
        page.get_by_role('link', name='applying a function', exact=True).click()
        assert page.url.endswith('/Applying-a-function/#transport')
        page.get_by_text('congrArg', exact=True).first.hover()
        page.locator('.tippy-content').filter(has_text='Congruence in the function argument').wait_for()
        print('PASS: Verso reference and declaration hover')

        # The editable model must retain the same example and its relationships.
        page.goto(base + '#/4/3')
        model = page.locator('section.present:not(.stack)')
        model.get_by_role('heading', name='The Abstract Data Model', exact=True).wait_for()
        for label in ['left_inverse_injective', 'Informal statement', 'Informal proof',
                      'Source reference', 'Lean association', 'equality_transport']:
            model.locator('svg').get_by_text(label, exact=True).wait_for()
        capture('model')

        # Graph initialization includes a deferred layout pass. Let it settle
        # before clicking, as the presenter would on arrival at this slide.
        page.goto(base + '#/4/6')
        graph = page.locator('[data-bp-slide-graph][data-bp-graph-status="ready"]')
        graph.wait_for()
        page.wait_for_timeout(1000)
        graph.locator('svg').get_by_text('left_inverse_injective', exact=True).click()
        page.locator('.bp_graph_preview:not([hidden])').get_by_text(
            'A function admitting a left inverse is injective.', exact=True).wait_for()
        for math in page.locator('.bp_graph_preview:not([hidden]) .katex-display').all():
            assert math.evaluate('(e) => e.scrollWidth <= e.clientWidth + 2'), 'graph formula overflows'
        capture('graph-preview')
        print('PASS: model and graph node preview')

        # The slide's iframe must switch snapshots and show real Lean statuses.
        page.goto(base + '#/4/7')
        frame = page.frame_locator('section.present:not(.stack) iframe')
        frame.locator('body[data-demo-ready="true"]').wait_for()
        frame.get_by_text('L∃∀N', exact=True).click()
        frame.get_by_text('[sorry in proof]', exact=True).wait_for()
        frame.get_by_role('link', name='After', exact=True).click()
        frame.locator('body[data-demo-ready="true"]').wait_for()
        frame.get_by_text('L∃∀N', exact=True).click()
        frame.get_by_text('[complete]', exact=True).wait_for()
        print('PASS: incomplete/complete proof snapshots')

        # Check the downstream effect where the presenter will show it.
        for state, count, status in [('before', 2, 'not ready'),
                                     ('after', 1, 'ready to formalize')]:
            page.goto(base + 'demo/' + state + '/Blueprint-Summary/')
            page.get_by_text('Metadata', exact=True).click()
            page.get_by_text(f'Quick wins ({count})', exact=True).click()
            badge = page.get_by_text('proof: ' + status, exact=True)
            badge.wait_for()
            badge.scroll_into_view_if_needed()
            capture('readiness-' + state)
        print('PASS: downstream proof readiness changes')
        assert not errors, '\n'.join(errors)
        browser.close()


if __name__ == '__main__':
    main()
