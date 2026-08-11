#!/usr/bin/env bash
# Regenerates SUBMISSION.pdf from SUBMISSION.md, and prints where each part lands
# so the page limits stay checkable rather than asserted.
set -euo pipefail
cd "$(dirname "$0")/.."
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
OUT=$(mktemp -d)
python3 -c "t=open('SUBMISSION.md').read(); open('$OUT/body.md','w').write(t[t.index('# Part A'):])"
cp build/submission.css build/front.html "$OUT/"
pandoc "$OUT/body.md" -s -c submission.css --include-before-body="$OUT/front.html" \
  --metadata title="" -o "$OUT/SUBMISSION.html"
(cd "$OUT" && "$CHROME" --headless --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="$OUT/SUBMISSION.pdf" "$OUT/SUBMISSION.html" >/dev/null 2>&1)
cp "$OUT/SUBMISSION.pdf" SUBMISSION.pdf
python3 - <<'PY'
from pypdf import PdfReader
r = PdfReader('SUBMISSION.pdf')
print(f"{len(r.pages)} pages")
for i, p in enumerate(r.pages, 1):
    print(f"  p{i}: {' '.join((p.extract_text() or '').split())[:60]}")
PY
