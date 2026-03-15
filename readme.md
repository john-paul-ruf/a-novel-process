# THE FREE COLONY

A disgraced logistics manager signs a one-way corporate charter to homestead a hostile exoplanet, knowing the company expects most colonists to die — but if he can keep twenty-four of the original forty-seven alive for five years, a buried clause grants them ownership of the land and a second chance he stopped believing he deserved.

**Status:** First Draft Complete — Audited & Revised — 27 chapters (~106,000 words)

---

## The Process

This novel is being written by a human author collaborating with **Zencoder** and **Claude Opus 4**.

The entire first draft — from bare-bones project scaffolding to 106,000 words of prose, a scene-by-scene outline, a story bible, a voice profile, and build tooling — was produced in a single working session on March 15, 2026. The draft then went through two full audit-and-revision passes in the same session. 88 commits total.

### How it works

1. **Voice discovery.** The author provided writing samples. Zencoder (running Claude Opus 4) analyzed them and produced a Voice Profile — sentence rhythm, emotional temperature, dialogue tendencies, tonal anchors, a list of tics to avoid.
2. **Pitch and structure.** Logline, synopsis, and scene-by-scene outline generated through iterative conversation. The author directed; the model built.
3. **Agent instructions.** A custom system prompt (`AGENTS.md`) defines a fiction ghostwriter persona called *Verity* — a 200-line set of craft standards, onboarding protocols, and writing process rules that govern every prose generation call.
4. **Chapter drafting.** Each chapter drafted individually against the outline and story bible, with continuity tracking and author notes kept in separate files. Opus 4 writes the prose; the author reviews, adjusts, and commits.
5. **Iteration.** 88 commits in one session. Each chapter typically goes through multiple passes — the model drafts, the author reads, flags land in `notes.md`, and the next draft absorbs the corrections.
6. **Audit.** Two full audit rounds after the draft was complete — a task list generated from the story bible, voice profile, and outline, then executed chapter by chapter. Continuity fixes, voice tightening, and structural adjustments across the full manuscript.

### What Zencoder provides

- **Orchestration.** Model routing, context management, and tool integration in the IDE. The author works in WebStorm; Zencoder handles the LLM calls.
- **Agent framework.** `AGENTS.md` is loaded as a system prompt on every interaction, giving the model persistent craft instructions and voice constraints.
- **Iterative workflow.** The conversational loop — draft, review, revise — runs inside the editor. No copy-pasting between browser tabs.

### What Claude Opus 4 provides

- **Prose generation.** All chapter drafts, outline material, and story bible entries are written by Opus 4 under the constraints of the voice profile and agent instructions.
- **Voice fidelity.** The model inhabits the author's voice rather than defaulting to generic literary prose — colloquial-smart register, deep interiority, fragments for emphasis, earned sentiment.
- **Structural memory.** Continuity across 106,000 words: character arcs, timeline consistency, motif tracking, foreshadowing planted in early chapters and paid off later.

### The numbers

| Metric | Value |
|---|---|
| **Session duration** | ~7 hours |
| **Commits** | 88 |
| **Chapters drafted** | 27 of 27 |
| **Audit passes** | 2 full rounds |
| **Prose word count** | ~106,000 |
| **Supporting material** | ~20,000 words (outline, bible, pitch, voice profile, notes) |
| **Build outputs** | Markdown, DOCX, EPUB, PDF |
| **Submission materials** | Query letter template, KDP listing |

### Timeline

All work completed March 15, 2026. First commit at 8:47 AM, last at 3:55 PM (CDT).

| Time | Phase | What happened |
|---|---|---|
| 8:47–8:55 | **Setup** | Project scaffolding, voice profile from writing samples |
| 8:55–9:02 | **Pitch** | Premise, logline, synopsis |
| 9:02–9:52 | **World-building** | Scene outline, story bible, character work, chapter structure |
| 9:56–10:04 | **Tooling** | Build scripts, task management, outline refinement |
| 10:06–10:35 | **Drafting (1–9)** | Part One: Landing — chapters 01 through 09 |
| 10:35–10:52 | **Drafting (10–12)** | Part Two begins — model switched back to Opus |
| 10:52–13:14 | **Drafting (12–22)** | Bulk of Part Two and start of Part Three |
| 13:14–14:41 | **Drafting (23–27)** | Part Three completed — final chapters |
| 14:41–14:52 | **First draft done** | Build, readme, 67th commit |
| 14:52–15:21 | **Audit round one** | Task list generated, executed across full manuscript |
| 15:23–15:55 | **Audit round two** | Second pass — continuity, voice tightening, final build |

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
AGENTS.md             # system prompt — fiction ghostwriter agent instructions
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
  build.js            # concatenate chapters -> markdown/docx/epub/pdf
  build.sh            # shell build script
  cover.js            # generate cover image
  cover.sh            # shell cover script
  diff-engine.sh      # diff utility
build/                # generated output (markdown, docx, epub, pdf)
submissions/
  agents/             # query letters and agent tracking
  kdp/                # KDP listing and self-publishing materials
```

---

## Commands

```bash
# Word count across all chapters
npm run wordcount

# Build manuscript (markdown + docx + epub + pdf)
npm run build

# Generate cover image (requires ImageMagick)
npm run cover
```

### Dependencies

- **Node.js** — script runner
- **Pandoc** — docx/epub generation (optional; `brew install pandoc`)
- **sharp** — PDF generation
- **md-to-pdf** — markdown to PDF conversion
- **ImageMagick** — cover generation (optional; `brew install imagemagick`)
