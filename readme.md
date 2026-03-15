# THE FREE COLONY

A disgraced logistics manager signs a one-way corporate charter to homestead a hostile exoplanet, knowing the company expects most colonists to die — but if he can keep twenty-four of the original forty-seven alive for five years, a buried clause grants them ownership of the land and a second chance he stopped believing he deserved.

**Status:** First Draft in Progress — 12 of 27 chapters drafted (~24,900 words)

---

## Structure

Third-person limited (primarily Cole Maren), past tense. Five years on Parcel 16b compressed across three parts, with nested narrative from a previous failed expedition's logs. The colony's survival hinges on keeping twenty-four of forty-seven colonists alive for exactly five years.

| Part | Chapters | Timeframe | Focus |
|---|---|---|---|
| **Part One: Landing** | 01–09 | Months 1–6 | Arrival and first adaptation (30% of novel) |
| **Part Two: The Count** | 10–20 | Months 6–30 | Deepening crisis and internal fracture (35% of novel) |
| **Part Three: Ownership** | 21–27 | Years 3–5 | The margin collapses; final choice (35% of novel) |

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
