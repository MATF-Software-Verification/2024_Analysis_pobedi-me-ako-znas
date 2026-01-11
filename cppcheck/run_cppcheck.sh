#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="$ROOT/pobedi-me-ako-znas"
OUTDIR="$ROOT/cppcheck/cppcheck-outputs"
mkdir -p "$OUTDIR"

# Qt .ui fajlovi nisu C++ - cppcheck ih preskače
# Fokusiramo se na kod: application + server + tests (ako postoje)
cppcheck --enable=all --inconclusive --std=c++17 \
  --xml --xml-version=2 \
  "$TARGET/application" "$TARGET/server" "$TARGET/tests" \
  2> "$OUTDIR/cppcheck.xml" || true

echo "Saved: $OUTDIR/cppcheck.xml"
