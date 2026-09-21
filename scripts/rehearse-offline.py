#!/usr/bin/env python3
"""Serve a disposable deployment prefix and run offline browser acceptance."""

import argparse
from functools import partial
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
import subprocess
import sys
import tempfile
from threading import Thread


class QuietHandler(SimpleHTTPRequestHandler):
    def log_message(self, *_args):
        pass


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--site', type=Path, default=Path('_slides'))
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--browser', help='Chrome executable; otherwise use system Chrome')
    parser.add_argument('--include-backup', action='store_true')
    args = parser.parse_args()
    site = args.site.resolve()
    if not (site / 'index.html').is_file():
        parser.error(f'no generated presentation in {site}')
    scripts = Path(__file__).resolve().parent
    browser = ['--browser', args.browser] if args.browser else []
    with tempfile.TemporaryDirectory(prefix='formath-rehearsal-') as directory:
        # A real path prefix catches accidental origin-root URLs. The artifact
        # remains untouched, and no existing preview server is started/stopped.
        (Path(directory) / 'formath').symlink_to(site, target_is_directory=True)
        server = ThreadingHTTPServer(('127.0.0.1', 0),
                                     partial(QuietHandler, directory=directory))
        thread = Thread(target=server.serve_forever, daemon=True)
        thread.start()
        base = f'http://127.0.0.1:{server.server_port}/formath/'
        try:
            for script, extra in [
                ('check-demo-browser.py', ['--screenshots', str(args.output / 'interactions')]),
                ('review-deck-browser.py', ['--output', str(args.output / 'slides'),
                                          *(['--include-backup'] if args.include_backup else [])]),
            ]:
                subprocess.run([sys.executable, str(scripts / script), '--url', base,
                                '--offline', *browser, *extra], check=True)
        finally:
            server.shutdown()
            server.server_close()
            thread.join()
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
