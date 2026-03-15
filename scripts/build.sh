#!/bin/bash
set -e

OUT_DIR="build"
mkdir -p "$OUT_DIR"

TITLE="PROJECT_TITLE"
AUTHOR="AUTHOR_NAME"
COVER="assets/cover.jpg"
MD_OUT="$OUT_DIR/PROJECT_SLUG.md"

cat /dev/null > "$MD_OUT"

if [ -f "$COVER" ]; then
  echo "![$TITLE]($COVER)" >> "$MD_OUT"
  echo "" >> "$MD_OUT"
fi
echo "# $TITLE" >> "$MD_OUT"
echo "" >> "$MD_OUT"
echo "*$AUTHOR*" >> "$MD_OUT"
echo "" >> "$MD_OUT"
echo "---" >> "$MD_OUT"
echo "" >> "$MD_OUT"

TOC_ENTRIES=()

make_anchor() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 ]//g' | tr ' ' '-' | sed 's/--*/-/g' | sed 's/^-//;s/-$//'
}

extract_title() {
  local dir="$1"
  local draft="chapters/$dir/draft.md"
  if [ -f "$draft" ]; then
    local label title
    label=$(sed -n '1s/^\*\*\(.*\)\*\*$/\1/p' "$draft")
    if [ -z "$label" ]; then
      label=$(sed -n '1s/^# \(.*\)$/\1/p' "$draft")
    fi
    title=$(sed -n '3s/^\*\(.*\)\*$/\1/p' "$draft")
    if [ -n "$label" ] && [ -n "$title" ]; then
      echo "$label — $title"
    elif [ -n "$label" ]; then
      echo "$label"
    fi
  fi
}

add_chapter() {
  local dir="$1"
  if [ -f "chapters/$dir/draft.md" ]; then
    cat <<'PAGEBREAK' >> "$MD_OUT"

```{=openxml}
<w:p><w:r><w:br w:type="page"/></w:r></w:p>
```

```{=latex}
\newpage
```

```{=html}
<div style="page-break-before: always;"></div>
```

PAGEBREAK
    if [[ "$dir" != 00-* ]]; then
      local entry anchor
      entry=$(extract_title "$dir")
      if [ -n "$entry" ]; then
        anchor=$(make_anchor "$entry")
        TOC_ENTRIES+=("- **[$entry](#$anchor)**")
        echo "[]{#$anchor}" >> "$MD_OUT"
        echo "" >> "$MD_OUT"
      fi
    fi
    cat "chapters/$dir/draft.md" >> "$MD_OUT"
    echo "" >> "$MD_OUT"
  fi
}

add_part() {
  local part_title="$1"
  local part_sub="$2"
  local anchor
  anchor=$(make_anchor "$part_title")
  TOC_ENTRIES+=("")
  TOC_ENTRIES+=("**[$part_title](#$anchor)**")
  cat <<'PAGEBREAK' >> "$MD_OUT"

```{=openxml}
<w:p><w:r><w:br w:type="page"/></w:r></w:p>
```

```{=latex}
\newpage
```

```{=html}
<div style="page-break-before: always;"></div>
```

PAGEBREAK
  echo "---" >> "$MD_OUT"
  echo "" >> "$MD_OUT"
  echo "# $part_title {#$anchor}" >> "$MD_OUT"
  echo "" >> "$MD_OUT"
  echo "*$part_sub*" >> "$MD_OUT"
  echo "" >> "$MD_OUT"
  echo "---" >> "$MD_OUT"
  echo "" >> "$MD_OUT"
}

for dir in $(ls -1 chapters/ 2>/dev/null | sort); do
  if [ -d "chapters/$dir" ] && [ "$dir" != "zz-about-the-author" ] && [[ "$dir" != _cut-* ]]; then
    part_file="chapters/$dir/part.txt"
    if [ -f "$part_file" ]; then
      part_title=$(sed -n '1p' "$part_file")
      part_sub=$(sed -n '2p' "$part_file")
      add_part "$part_title" "$part_sub"
    fi
    add_chapter "$dir"
  fi
done

if [ -f "chapters/zz-about-the-author/draft.md" ]; then
  cat <<'PAGEBREAK' >> "$MD_OUT"

```{=openxml}
<w:p><w:r><w:br w:type="page"/></w:r></w:p>
```

```{=latex}
\newpage
```

```{=html}
<div style="page-break-before: always;"></div>
```

PAGEBREAK
  cat "chapters/zz-about-the-author/draft.md" >> "$MD_OUT"
  echo "" >> "$MD_OUT"
fi

TOC_FILE=$(mktemp)
echo "## Contents" >> "$TOC_FILE"
echo "" >> "$TOC_FILE"
for entry in "${TOC_ENTRIES[@]}"; do
  echo "$entry" >> "$TOC_FILE"
  if [ -n "$entry" ]; then
    echo "" >> "$TOC_FILE"
  fi
done
echo "---" >> "$TOC_FILE"
echo "" >> "$TOC_FILE"

HEADER_FILE=$(mktemp)
head -6 "$MD_OUT" > "$HEADER_FILE"
BODY_FILE=$(mktemp)
tail -n +7 "$MD_OUT" > "$BODY_FILE"
cat "$HEADER_FILE" "$TOC_FILE" "$BODY_FILE" > "$MD_OUT"
rm "$HEADER_FILE" "$TOC_FILE" "$BODY_FILE"

WORDS=$(wc -w < "$MD_OUT" | tr -d ' ')
echo "✓ Markdown built: $MD_OUT ($WORDS words)"

if command -v pandoc &> /dev/null; then
  DOCX_OUT="$OUT_DIR/PROJECT_SLUG.docx"
  pandoc "$MD_OUT" \
    --metadata title="$TITLE" \
    --metadata author="$AUTHOR" \
    --reference-doc=scripts/reference.docx \
    -o "$DOCX_OUT" 2>/dev/null \
  || pandoc "$MD_OUT" \
    --metadata title="$TITLE" \
    --metadata author="$AUTHOR" \
    -o "$DOCX_OUT"
  echo "✓ Word built:     $DOCX_OUT"

  EPUB_OUT="$OUT_DIR/PROJECT_SLUG.epub"
  EPUB_MD=$(mktemp)
  sed '/^!\[.*\](assets\/cover\.jpg)$/d' "$MD_OUT" \
    | sed '/```{=openxml}/,/```/{/```{=openxml}/d;/<w:p>.*<\/w:p>/d;/^```$/d;}' \
    | sed '/```{=latex}/,/```/{d;}' \
    | sed '/^## Contents$/,/^---$/{d;}' \
    | sed 's/^\*\*\(Chapter [0-9][0-9]*\)\*\*$/# \1/' \
    | awk '
/^# / && !/\{#/ {
  heading = $0
  if (getline > 0 && $0 == "") {
    if (getline > 0 && $0 ~ /^\*[^*]+\*$/) {
      sub(/^\*/, "", $0)
      sub(/\*$/, "", $0)
      print heading " — " $0
      print ""
      next
    } else {
      print heading
      print ""
      print $0
      next
    }
  } else {
    print heading
    print $0
    next
  }
}
{ print }
' > "$EPUB_MD"
  COVER_ARGS=""
  if [ -f "$COVER" ]; then
    COVER_ARGS="--epub-cover-image=$COVER"
  fi
  pandoc "$EPUB_MD" \
    --metadata title="$TITLE" \
    --metadata author="$AUTHOR" \
    --metadata lang=en \
    $COVER_ARGS \
    --toc \
    --toc-depth=1 \
    -o "$EPUB_OUT"
  rm "$EPUB_MD"
  echo "✓ EPUB built:     $EPUB_OUT"

  PDF_OUT="$OUT_DIR/PROJECT_SLUG.pdf"
  PDF_MD=$(mktemp)
  sed '/```{=openxml}/,/```/{/```{=openxml}/d;/<w:p>.*<\/w:p>/d;/^```$/d;}' "$MD_OUT" \
    | sed '/^\[]{#/d' \
    | sed '/^!\[.*\](assets\/cover\.jpg)$/d' \
    | sed '/^## Contents$/,/^---$/{d;}' \
    > "$PDF_MD"
  if command -v xelatex &> /dev/null; then
    pandoc "$PDF_MD" \
      --metadata title="$TITLE" \
      --metadata author="$AUTHOR" \
      --pdf-engine=xelatex \
      -V geometry:margin=1in \
      -V fontsize=12pt \
      -V mainfont="Times New Roman" \
      -o "$PDF_OUT"
    echo "✓ PDF built:      $PDF_OUT"
  elif command -v pdflatex &> /dev/null; then
    pandoc "$PDF_MD" \
      --metadata title="$TITLE" \
      --metadata author="$AUTHOR" \
      --pdf-engine=pdflatex \
      -V geometry:margin=1in \
      -V fontsize=12pt \
      -o "$PDF_OUT"
    echo "✓ PDF built:      $PDF_OUT"
  elif command -v lualatex &> /dev/null; then
    pandoc "$PDF_MD" \
      --metadata title="$TITLE" \
      --metadata author="$AUTHOR" \
      --pdf-engine=lualatex \
      -V geometry:margin=1in \
      -V fontsize=12pt \
      -o "$PDF_OUT"
    echo "✓ PDF built:      $PDF_OUT"
  elif command -v typst &> /dev/null; then
    pandoc "$PDF_MD" \
      --metadata title="$TITLE" \
      --metadata author="$AUTHOR" \
      --pdf-engine=typst \
      --toc \
      --toc-depth=1 \
      -o "$PDF_OUT"
    echo "✓ PDF built:      $PDF_OUT"
  else
    echo "⚠ No PDF engine found — skipping .pdf (brew install --cask basictex, then: sudo tlmgr install collection-fontsrecommended)"
  fi
  rm "$PDF_MD"
else
  echo "⚠ pandoc not found — skipping .docx/.epub/.pdf (brew install pandoc)"
fi
