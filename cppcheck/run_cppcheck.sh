#!/usr/bin/env bash
set -euo pipefail

# Provera da li je cppcheck instaliran
if ! command -v cppcheck &> /dev/null; then
  echo "Cppcheck nije instaliran. Instaliraj: sudo apt install cppcheck"
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="$ROOT/pobedi-me-ako-znas"
OUTDIR="$ROOT/cppcheck/cppcheck-outputs"
OUTXML="$OUTDIR/cppcheck.xml"

mkdir -p "$OUTDIR"

echo "Pokrećem cppcheck nad:"
echo "  - $TARGET/application"
echo "  - $TARGET/server"
echo "  - $TARGET/tests"

cppcheck --enable=all --inconclusive --std=c++17 \
  --suppress=missingInclude \
  --xml --xml-version=2 \
  --output-file="$OUTXML" \
  "$TARGET/application" "$TARGET/server" "$TARGET/tests" || true

# Provera da je XML zaista kreiran
if [ ! -f "$OUTXML" ]; then
  echo "Cppcheck nije uspeo da kreira XML izveštaj: $OUTXML"
  exit 1
fi

echo "Saved: $OUTXML"
