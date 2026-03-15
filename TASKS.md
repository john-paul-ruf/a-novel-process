# Audit Tasks — THE FREE COLONY

Audit of all 27 chapter drafts against story bible, scene outline, and voice profile.

---

## AGENTS.md Violations

### TASK-001: Ch 12 draft.md contains Author Notes — COMPLETE
- **File:** `chapters/12-democracy/draft.md`, lines 105-119
- **Issue:** Author Notes, structural notes, continuity tracking, off-voice flags, and word count are appended directly to the `draft.md` file. AGENTS.md rule states: "RULE: `draft.md` files contain prose only. Never append Author Notes, structural notes, continuity tracking, off-voice flags, word counts, or any meta-commentary to a `draft.md` file."
- **Fix:** ~~Move lines 105-119 to `chapters/12-democracy/notes.md` (which already exists) and remove them from `draft.md`.~~ Done. Author Notes removed from `draft.md`. Content already existed in `notes.md`.

---

## Continuity Errors

### TASK-002: Patricia dies twice — Ch 16 and Ch 22 — COMPLETE
- **Files:** `chapters/16-fever/draft.md`, `chapters/19-narrowing/draft.md`, `chapters/17-elena-year-two/draft.md`, `source/scene-outline.md`, `source/story-bible.md`
- **Issue:** Patricia was killed in Ch 16 AND Ch 22. Ch 22 (Month 37) is the canonical death — the Haruki-Patricia arc depends on it.
- **Fix:** Replaced Patricia's Ch 16 death with new colonist **Hana** (age 41, former agricultural researcher, died from immune depletion — she was in the non-priority triage tier and didn't receive Dana's compound in time). Death count 34→32 preserved (Hana + James). Updated Ch 16 death scene, Joss's fever scene reference, Cole's dead-names reflection, Ch 17 "After Hana and James" reference, Ch 19 dead list, scene outline ("Two die"), and story bible timeline. Patricia now survives Ch 16 (prioritized in triage, compound works), lives through Ch 17-21 with managed cough, dies canonically in Ch 22 Month 37. All downstream references (Ch 22, 23, 25, 27) verified consistent.

### TASK-003: Scene outline says "Three die" in Ch 16 but death tracker says 2 — COMPLETE
- **File:** `source/scene-outline.md`, Ch 16 Beat 2
- **Issue:** ~~Outline text read "Three die. Thirty-two." but death tracker showed 34→32 (2 deaths).~~
- **Fix:** Done. Corrected to "Two die. Thirty-two." Story bible timeline also corrected to "two deaths (Hana, James)."

### TASK-004: Ch 19 dead names list includes Patricia prematurely — COMPLETE
- **File:** `chapters/19-narrowing/draft.md`, line 71
- **Issue:** ~~Patricia listed among the dead in Months 23-26, but she doesn't die until Month 37 (Ch 22).~~
- **Fix:** Done. Replaced "Patricia" with "Hana" in the dead names list. Sixteen names, sixteen deaths — count verified.

### TASK-005: Ch 27 Haruki death — count says 23 but story bible says 24 at invocation
- **File:** `chapters/27-tuesday/draft.md`, line 331
- **Issue:** After Haruki dies, Cole's count registers "Twenty-three." The story bible specifies 24 alive at invocation, with Haruki dying "hours after the clause is invoked." The draft correctly has Haruki dying on the evening of Day 1,826 after the clause triggers at 0000 hours. The count 24→23 is narratively correct (Haruki dies after invocation, reducing the living count). This is NOT an error — the invocation threshold was met at 24, and the post-invocation death is tracked correctly. No fix needed, but flagging for awareness since the final count (22) differs from the invocation count (24).
- **Status:** Verified correct. No action needed.

### TASK-006: Lily's age — "She's nine" in Ch 16 (Month 17-18) — COMPLETE
- **File:** `chapters/16-fever/draft.md`, line 133
- **Issue:** Cole says "She's nine" but Lily is 9 at Day 0; Ch 16 is Month 17-18 plus ~3 months transit (~20-21 months elapsed). She would be 10.
- **Fix:** Done. Changed to "She's ten" in draft (line 133 and line 141) and scene outline. Author confirmed accuracy over frozen-memory read.

---

## Chapter Heading Format Inconsistencies

### TASK-007: Three different heading formats across chapters
- **Files:** All chapter `draft.md` files
- **Issue:** Chapter headings use three different formats:
  - **Format A** (Ch 1-4): Bold, word numbers, no quotes around title. E.g., `**Chapter One — Clause 9.4.2**`
  - **Format B** (Ch 11-13, 15-17): H1 header, numeric, no quotes. E.g., `# Chapter 11 — Creep`
  - **Format C** (Ch 5-10, 14, 18-27): H1 header, numeric, quotes around title. E.g., `# Chapter 05 — "Three"`
- **Affected files:**
  - Format A: `01-first-chapter`, `02-transit`, `03-landing`, `04-the-rules`
  - Format B: `11-creep`, `12-democracy`, `13-the-structure`, `15-supply-lines`, `16-fever`, `17-elena-year-two`
  - Format C: `05-three`, `06-ghost-colony`, `07-factions`, `08-roots`, `09-the-count`, `10-second-cycle`, `14-signal`, `18-the-creep-solution`, `19-narrowing`, `20-silence`, `21-confession`, `22-the-vote`, `23-no-margin`, `24-the-shuttle`, `25-the-math`, `26-eleven-months`, `27-tuesday`
- **Fix:** Standardize all chapters to a single format. Recommend Format C (`# Chapter XX — "Title"`) as it is the most common (17 of 27 chapters).

---

## Voice Profile Violations

### TASK-008: Excessive use of recursive "and the X was the Y" constructions
- **Voice profile rule:** "recursive 'and the X was the Y' constructions — limit to rare, high-impact moments at most"
- **Issue:** The construction appears frequently across later chapters, far exceeding "rare." Examples include:
  - Ch 19: "and the running was the point"
  - Ch 23: "and the choosing was the thing"
  - Ch 24: "and the margin was a razor, and the razor was the next eleven months, and the next eleven months were a choice" (triple chain)
  - Ch 25: "and the gap was the kind that widened under load"
  - Ch 26: "and the keeping was the hardest thing she'd ever done"; "and the normalcy would be the most alien thing about her"; "and the stillness was the most violent thing"; "and the walking was the walking, and the sameness was the thing she was fighting for, and the fighting was the walking, and the walking was enough" (quadruple chain)
  - Ch 27: "and the walking was the ritual and the ritual was the structure and the structure was what held him" (triple chain); "and the sameness was the point"; "and the touching was the knowing, and the knowing was not relief but recognition"; "the voice was the treatment and the treatment was the man" (used 3 times in Ch 27 alone); "and the receiving was the thing the framework couldn't do"; "and the choosing was the thing he'd live with"; "and the making was the thing the charter hadn't anticipated"; "and the standing was the only thing available"; "and the favor was the thing he wanted Cole to hear"
- **Concentration:** The pattern intensifies from Ch 23 onward. Ch 27 alone has 12+ instances. Early chapters (1-15) have few or none.
- **Fix:** Reduce to 3-5 carefully placed instances across the full manuscript, reserved for peak emotional/thematic moments. The triple/quadruple chains (Ch 24 line 223, Ch 26 line 331, Ch 27 line 23) are the most egregious and should be revised first.

### TASK-009: Two uses of "the not-X was the X" inversion — voice profile says "never use"
- **Voice profile rule:** "'the not-X was the X' inversions (e.g., 'the not-knowing was the knowing') — never use"
- **Instances:**
  1. `chapters/26-eleven-months/draft.md` (line 217): "the not-checking was the gap that the next failure entered through"
  2. `chapters/25-the-math/draft.md` (line 181): "the not-knowing was the thing that made the choice impossible"
- **Fix:** Rewrite both constructions. E.g., "the gap came from stopping the checks" and "the uncertainty was the thing that made the choice impossible."

### TASK-010: Polysyndeton in Ch 27
- **Voice profile rule:** "polysyndeton (chaining clauses or items with repeated 'and' — the 'and and and' technique) — never use"
- **Instance:** `chapters/27-tuesday/draft.md`, line 405: "the twenty-two people who'd survived the math and the planet and the corporation and the clause and the five years and the specific, relentless accumulation of days"
- **Note:** This is a borderline case — it chains six items with repeated "and." The voice profile says "never use" polysyndeton. However, this appears at the novel's emotional climax.
- **Fix:** Rewrite to avoid the chain. E.g., use a list with commas: "the twenty-two people who'd survived the math, the planet, the corporation, the clause, the five years — the specific, relentless accumulation of days..."

---

## Scene Outline vs. Draft Discrepancies

### TASK-011: Ch 1 charter length — outline says 200 pages, draft says 247
- **Files:** `source/scene-outline.md` (Ch 1, Beat 1: "full 200-page charter"), `chapters/01-first-chapter/draft.md` (line 7: "all 247 pages of it, not the 200 they'd claimed")
- **Issue:** The outline says Cole reads the "full 200-page charter." The draft changes this to 247 pages vs. the 200 claimed in recruitment materials, adding another layer of Asterlyne's dishonesty.
- **Assessment:** The draft's version is a stronger choice (builds the deception motif). But the outline should be updated to match if this is the canonical version.
- **Fix:** Update scene outline Ch 1 Beat 1 to reflect 247-page charter vs. 200 claimed.

### TASK-012: Ch 5 death count — outline says 47→44 but draft counts 47→46→45→44
- **File:** `chapters/05-three/draft.md`
- **Issue:** Minor: the outline says "Three deaths" and jumps to 44, while the draft carefully counts each death (Lev→46, Priya→45, Vogel→44). This is correct — not an error. The draft properly names and sequences the three deaths.
- **Status:** Verified correct. No action needed.

### TASK-013: Ch 22 — verify the unnamed "fall during construction" death
- **File:** `chapters/22-the-vote/draft.md`
- **Issue:** The scene outline describes two deaths in Ch 22: "A fall during construction" and "A slow respiratory failure Haruki can't treat." The draft should name both. Verify the first death (fall) is properly depicted and counted (26→25→24).
- **Fix:** Verify in full Ch 22 draft (truncated during audit). Ensure both deaths are depicted and the count reaches 24 correctly.

---

## Structural Notes

### TASK-014: "Enough, now" placement — verified correct
- **Files:** `chapters/23-no-margin/draft.md` (line 99), `chapters/27-tuesday/draft.md` (line 303)
- **Issue:** "Enough, now" appears as Elena's final log entry in Ch 23 (correct per continuity flags). Ch 27 references it in past tense during Haruki's death scene (appropriate callback). No premature appearances in Ch 6, 8, 10, or 11.
- **Status:** Verified correct. No action needed.

### TASK-015: "Holdfast" naming — verified correct
- **Issue:** "Holdfast" first appears in Ch 23 during the naming vote (line 221). All uses in Ch 24-27 are post-naming. No premature appearances in Ch 1-22 drafts. Ch 6 continuity flag (premature reference) was previously resolved.
- **Status:** Verified correct. No action needed.

### TASK-016: Elena log pacing — verified correct
- **Issue:** Elena's logs are parceled correctly across chapters:
  - Ch 6: Month 1-2 logs only
  - Ch 8: Year One Months 3-12, ends "We're going to make it"
  - Ch 9: Year Two data core opened, not read
  - Ch 10: Year Two Months 13-15
  - Ch 11: Recognition of Month 15 creep; reads Months 16-17
  - Ch 17: Year Two social collapse shared with colony
  - Ch 23: Final entry "Enough, now"
- **Status:** Verified correct. No action needed.

### TASK-017: POV assignments — verified correct
- **Issue:** All POV assignments match the scene outline:
  - Cole: Ch 1-6, 8-11, 13, 15-17, 19, 23-25, 27
  - Ren: Ch 7, 12, 20, 26
  - Dana: Ch 14, 18, 21
- **Status:** Verified correct. No action needed.

---

## Summary

| Priority | Task ID | Description | Status |
|---|---|---|---|
| **Critical** | TASK-002 | Patricia dies twice (Ch 16 and Ch 22) | Complete |
| **Critical** | TASK-003 | Scene outline "Three die" vs death tracker "Two" in Ch 16 | Complete |
| **Critical** | TASK-004 | Ch 19 lists Patricia as dead prematurely | Complete |
| **High** | TASK-001 | Ch 12 draft.md contains Author Notes | Complete |
| **High** | TASK-008 | Excessive recursive "and the X was the Y" constructions | Needs revision pass |
| **High** | TASK-009 | Two "not-X was the X" inversions (voice profile: never use) | Needs fix |
| **Medium** | TASK-007 | Three different chapter heading formats | Needs standardization |
| **Medium** | TASK-010 | Polysyndeton in Ch 27 climax | Needs revision |
| **Low** | TASK-011 | Scene outline charter page count outdated | Needs update |
| **Info** | TASK-005 | Ch 27 count 24→23→22 post-invocation | Verified correct |
| **Info** | TASK-006 | Lily's age "She's nine" in Ch 16 | Complete |
| **Info** | TASK-012 | Ch 5 death sequencing | Verified correct |
| **Info** | TASK-013 | Ch 22 unnamed death verification | Needs full-text check |
| **Info** | TASK-014 | "Enough, now" placement | Verified correct |
| **Info** | TASK-015 | "Holdfast" naming timeline | Verified correct |
| **Info** | TASK-016 | Elena log pacing | Verified correct |
| **Info** | TASK-017 | POV assignments | Verified correct |
