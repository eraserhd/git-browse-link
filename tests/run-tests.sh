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

t 'translates https://github.com origins without .git suffix into github browse links' \
    -remote origin https://github.com/foo/bar \
    -command 'git browse-link repo/dir/file.txt' \
    -output 'https://github.com/foo/bar/blob/ce1ced46695def162cadf35f7f02df67cd215c60/dir/file.txt'

summarize
