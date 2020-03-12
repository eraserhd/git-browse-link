#!/bin/sh

TEST_COUNT=0
TEST_FAILURES=0

setUpFixtures() {
    rm -rf origin/ repo/
    tar -xzf fixtures.tgz
}

fail() {
    if [ $TEST_OK == false ]; then
        return
    fi
    TEST_ERROR="$1"
    TEST_OK=false
}

t() {
    TEST_DESCRIPTION="$1"
    shift

    TEST_COUNT=$(( TEST_COUNT + 1 ))
    TEST_OK=true
    TEST_ERROR=''
    TEST_COMMAND=''
    TEST_OUTPUT=''

    setUpFixtures

    while [ $# -gt 0 ]; do
        case "$1" in
        -remote)
            shift 2
            ;;
        -command)
            TEST_COMMAND="$2"
            shift 2
            ;;
        -output)
            TEST_OUTPUT="$2"
            shift 2
            ;;
        *)
            fail "t: unknown option $1"
            shift
            ;;
        esac
    done

    if [ $TEST_OK == true ]; then
        printf 'ok %d - %s\n' $TEST_COUNT "$TEST_DESCRIPTION"
    else
        printf 'not ok %d - %s\n' $TEST_COUNT "$TEST_DESCRIPTION"
        if [ -n "$TEST_ERROR" ]; then
            printf '# %s\n' "$TEST_ERROR"
        fi
        TEST_FAILURES=$(( TEST_FAILURES + 1 ))
    fi
}

summarize() {
    printf '1..%d\n' $TEST_COUNT
    exit $(( TEST_FAILURES > 100 ? 100 : TEST_FAILURES ))
}

t 'translates git@github.com origins into github browse links' \
    -remote origin=git@github.com:foo/bar.git \
    -command 'git browse-link tests/repo/dir/file.txt' \
    -output 'https://github.com/foo/bar/blob/1111/dir/file.txt'

summarize
