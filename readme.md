# PROJECT_TITLE

[One-sentence description of the project.]

**Author:** AUTHOR_NAME
**Status:** [Current status]

---

## Structure

[Describe the novel's organizational structure — acts, parts, timeline, etc.]

| Act | Chapters | Timeframe |
|---|---|---|
| **Act One** | 01–?? | |
| **Act Two** | ??–?? | |
| **Act Three** | ??–?? | |

---

## Repository Layout

```
chapters/
  NN-slug/
    draft.md          # chapter prose
    notes.md          # author notes, continuity tracking, flags
    part.txt          # act/part divider (if chapter opens a new act)
source/
  the-pitch.md        # premise, synopsis, full pitch document
  scene-outline.md    # scene-by-scene outline
  story-bible.md      # characters, timeline, locations, motifs, continuity
  voice-profile.md    # client voice profile
scripts/
  build.sh            # concatenate chapters -> markdown/docx/epub
  cover.sh            # generate cover image (requires ImageMagick)
assets/               # cover art and images
build/                # generated output (markdown, docx, epub)
submissions/          # query letters, agent tracking, KDP listing
```

---

## Commands

```bash
# Word count across all chapters
npm run wordcount

# Build manuscript (markdown + docx + epub if pandoc is installed)
npm run build

# Generate cover image (requires ImageMagick)
npm run cover
```

### Dependencies

- **Node.js** — script runner
- **Pandoc** — docx/epub generation (optional; `brew install pandoc`)
- **ImageMagick** — cover generation (optional; `brew install imagemagick`)
