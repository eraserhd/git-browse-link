#!/bin/sh

source ./harness.sh

t 'translates git@github.com origins into github browse links' \
    -remote origin git@github.com:foo/bar.git \
    -command 'git browse-link repo/dir/file.txt' \
    -output 'https://github.com/foo/bar/blob/ce1ced46695def162cadf35f7f02df67cd215c60/dir/file.txt'

t 'translates https://github.com origins into github browse links' \
    -remote origin https://github.com/foo/bar.git \
    -command 'git browse-link repo/dir/file.txt' \
    -output 'https://github.com/foo/bar/blob/ce1ced46695def162cadf35f7f02df67cd215c60/dir/file.txt'

t 'translates git@github.com origins without .git suffix into github browse links' \
    -remote origin git@github.com:foo/bar \
    -command 'git browse-link repo/dir/file.txt' \
    -output 'https://github.com/foo/bar/blob/ce1ced46695def162cadf35f7f02df67cd215c60/dir/file.txt'

t 'translates https://github.com origins without .git suffix into github browse links' \
    -remote origin https://github.com/foo/bar \
    -command 'git browse-link repo/dir/file.txt' \
    -output 'https://github.com/foo/bar/blob/ce1ced46695def162cadf35f7f02df67cd215c60/dir/file.txt'

## Positions

t 'adds line anchor for a single line when position is on a single line' \
    -remote origin https://github.com/foo/bar \
    -command 'git browse-link repo/dir/file.txt 3.4,3.6' \
    -output 'https://github.com/foo/bar/blob/ce1ced46695def162cadf35f7f02df67cd215c60/dir/file.txt#L3'

t 'adds line anchor for multiple lines when position spans multiple lines' \
    -remote origin https://github.com/foo/bar \
    -command 'git browse-link repo/dir/file.txt 3.4,7.6' \
    -output 'https://github.com/foo/bar/blob/ce1ced46695def162cadf35f7f02df67cd215c60/dir/file.txt#L3-L7'

summarize
