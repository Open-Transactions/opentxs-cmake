#!/usr/bin/env sh

clang_format_bin=clang-format

if ! command -v clang-format >/dev/null ; then
    clang_format_bin=clang-format-6.0
    if ! command -v clang-format-6.0 >/dev/null ; then
        echo -n "error: please install clang-format v6.0 in order to be able"
        echo    " to use this pre-commit git-hook"
        exit 1
    fi
fi

files="$@"

for file in $files; do
    cp "${file}" "${file}.clangformat"
    "${clang_format_bin}" -i "${file}.clangformat"
    git diff --no-index "${file}" "${file}.clangformat" | cat
    rm "${file}.clangformat"
done

