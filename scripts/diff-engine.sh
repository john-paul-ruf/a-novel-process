#!/bin/bash

OUTPUT="diffs-for-claude.md"

echo "# Git Diff History" > "$OUTPUT"
echo "Generated: $(date)" >> "$OUTPUT"
echo "" >> "$OUTPUT"

FILES=(
  "source/the-pitch.md"
  "source/story-bible.md"
  "source/scene-outline.md"
)

echo "## Debug Info" >> "$OUTPUT"
echo "**Repo root:** $(git rev-parse --show-toplevel)" >> "$OUTPUT"
echo "**Working dir:** $(pwd)" >> "$OUTPUT"
echo "" >> "$OUTPUT"

echo "### All tracked files matching target names:" >> "$OUTPUT"
git ls-files | grep -iE "pitch|story|scene|bible|outline|voice" >> "$OUTPUT"
echo "" >> "$OUTPUT"

for FILE in "${FILES[@]}"; do
  echo "---" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
  echo "# FILE: $FILE" >> "$OUTPUT"
  echo "" >> "$OUTPUT"

  ROOT=$(git rev-parse --show-toplevel)
  COMMITS=$(git -C "$ROOT" log --reverse --format="%H %ai %s" -- "$FILE" 2>/dev/null)

  if [ -z "$COMMITS" ]; then
    echo "*No commits found for $FILE*" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    continue
  fi

  while IFS= read -r COMMIT_LINE; do
    HASH=$(echo "$COMMIT_LINE" | awk '{print $1}')
    DATE=$(echo "$COMMIT_LINE" | awk '{print $2, $3}')
    MSG=$(echo "$COMMIT_LINE" | cut -d' ' -f5-)

    echo "## Commit: $HASH" >> "$OUTPUT"
    echo "**Date:** $DATE" >> "$OUTPUT"
    echo "**Message:** $MSG" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo '```diff' >> "$OUTPUT"
    git -C "$ROOT" show "$HASH" -- "$FILE" >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
    echo "" >> "$OUTPUT"

  done <<< "$COMMITS"

done

echo "Done. Output written to $OUTPUT"
