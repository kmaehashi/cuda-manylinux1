#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
import sys


def _fetch_dockerfile(url):
    lines = []
    for line in requests.get(url).text.splitlines():
        if (line == 'ARG repository' or
                line.startswith('FROM ') or
                line.startswith('LABEL maintainer ')):
            continue
        lines.append(line)
    return lines


def main(urls):
    lines = [
        'FROM quay.io/pypa/manylinux1_x86_64',
    ]
    for url in urls:
        lines += [
            '',
            '###',
            '### {}'.format(url),
            '###',
        ] + _fetch_dockerfile(url)
    print('\n'.join(lines))


if __name__ == '__main__':
    main(sys.argv[1:])
