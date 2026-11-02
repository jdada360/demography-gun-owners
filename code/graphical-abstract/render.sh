#!/usr/bin/env bash
# Render the graphical-abstract SVGs to 300-dpi PNG and to PDF via headless Chrome.
# Canvas is 2100 x 840 px = 7.0 x 2.8 in at 300 dpi (Elsevier minimum is 1328 x 531).
set -euo pipefail

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
HERE="$(cd "$(dirname "$0")" && pwd)"
OUT="$HERE/../../output/graphical-abstract"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

python3 -I "$HERE/build.py"

for name in concept-a concept-b concept-c; do
  svg="$OUT/$name.svg"

  # PNG: screenshot the SVG at 1:1, then tag it 300 dpi.
  "$CHROME" --headless --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
    --default-background-color=FFFFFFFF --window-size=2100,840 \
    --screenshot="$OUT/$name.png" "file://$svg" >/dev/null 2>&1
  sips -s dpiWidth 300 -s dpiHeight 300 "$OUT/$name.png" >/dev/null

  # PDF: wrap the SVG in a page sized to 7 x 2.8 in so the vector art prints to spec.
  cat > "$TMP/$name.html" <<HTML
<!doctype html><meta charset="utf-8">
<style>
  @page { size: 7in 2.8in; margin: 0; }
  html,body { margin:0; padding:0; }
  img { display:block; width:7in; height:2.8in; }
</style>
<img src="file://$svg">
HTML
  "$CHROME" --headless --disable-gpu --no-pdf-header-footer \
    --print-to-pdf="$OUT/$name.pdf" "file://$TMP/$name.html" >/dev/null 2>&1

  # TOC legibility check: the thumbnail Elsevier actually shows.
  cp "$OUT/$name.png" "$OUT/$name-thumb.png"
  sips -z 200 500 "$OUT/$name-thumb.png" >/dev/null

  printf '%-10s ' "$name"
  sips -g pixelWidth -g pixelHeight -g dpiWidth "$OUT/$name.png" | tail -3 | tr -d ' \n'
  printf '\n'
done

echo "output: $(cd "$OUT" && pwd)"
