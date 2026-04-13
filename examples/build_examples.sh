#!/usr/bin/env bash
# build_examples.sh — preprocesses and compiles all *.simf examples
# Requires: mcpp, simc (both on PATH)

set -euo pipefail

EXAMPLES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
failed=0

for src in "$EXAMPLES_DIR"/*.simf; do
    name="$(basename "$src" .simf)"
    tmp="$EXAMPLES_DIR/$name.simf.tmp"

    echo "Building $(basename "$src")..."

    if mcpp -P "$src" "$tmp" && simc "$tmp"; then
        echo "  OK"
    else
        echo "  FAILED"
        failed=$((failed + 1))
    fi

    rm -f "$tmp"
done

if [ "$failed" -gt 0 ]; then
    echo "$failed example(s) failed to build." >&2
    exit 1
fi

echo "All examples built successfully."
