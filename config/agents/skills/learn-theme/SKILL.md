---
name: "learn-theme"
description: "Mentored learning for any new theme (tools, languages, frameworks, concepts) — grill-me intake interview, hands-on curriculum sessions grounded in learning science, and progress tracked in the ai-mentor knowledge repo"
version: 2
created: "2026-09-10"
updated: "2026-09-23"
---
## When to Use
Use when the user wants to learn a new theme/topic — phrases like "learn X", "teach me X", "use learn-theme for X", or "continue my X lessons". Works for any topic: CLI tools, languages, frameworks, protocols, algorithms, concepts.

## Procedure
1. NEW THEME INTAKE: locate the repo at ~/Documents/projects/study/ai-mentor (colocated jj repo) and create <theme>/ inside it. If the theme dir already exists, skip to SESSION.
2. Run the grill-me-interactive skill as the intake interview: establish why (the concrete real-world outcome the user is chasing — push back on "to understand X"), starting point (current skill level), destination (observable success criteria), constraints, full unit list, what to demote to one-line mentions or drop, topic mode (tool vs concept), and for tool topics the sandbox location outside the repo.
3. Write GOALS.md in the theme dir with the mission header — Why (1-3 sentences), Success looks like (specific observable abilities), Constraints, Out of scope (adjacent topics excluded to protect focus) — then starting point, mode, and the unit list with status (pending / current / done / demoted / dropped). Write PROGRESS.md: sessions completed, units done, key facts learned, quiz gaps to re-check, next session plan. Describe a jj commit.
4. SESSION OPEN: read GOALS.md and PROGRESS.md. Run a cumulative spaced-retrieval quiz: previous session's units plus interleaved questions from older units, weighted toward recorded gaps. Grade for storage strength (delayed recall), not fluency — a smooth answer given moments after teaching is weak evidence. Fill gaps before new material.
5. TEACH 2-3 units per session, sized to the zone of proximal development: challenge just enough given quiz evidence, harder where recall is solid, slower where it isn't. Tool mode: narrate the theory, show what to do and what it does, then the user runs it themselves and shows the overall result; verify the resulting state forensically (repo state, output, logs). Concept mode: theory, worked examples, then Q&A testing understanding.
6. Build the curriculum from agent research (context7 docs / web_search), never from training-data memory alone and never from user-provided materials as the backbone.
7. Verify volatile facts before teaching: version-specific flags, APIs, and behavior get checked against current docs and taught with the source named; stable theory may be taught from knowledge.
8. Grow NOTES.md with each unit as a cheat-sheet style permanent reference, including a Terms section: 1-2 sentence definitions of what a term IS, promoted only after the user demonstrably uses it correctly; when synonyms exist, pick the winner and list the rest as avoid-aliases. Update PROGRESS.md: units done, key facts, quiz gaps to re-check, next session plan. Describe the end-of-session jj commit.
9. RESUME: when the user says "continue my X lessons" in any session, read the theme's PROGRESS.md and continue exactly where it says.
10. GRADUATION: when the unit list is exhausted, run a final exam — mixed Q&A plus practical drills covering all units, testing delayed recall of the whole theme. Pass: mark PROGRESS.md complete; NOTES.md stays the permanent reference. Fail: schedule the weak units for repeat next session.

## Pitfalls
- Never track progress in project memory — PROGRESS.md in the theme dir is the single source of truth
- Never place practice sandboxes inside the ai-mentor repo — they are scratch dirs outside it (e.g. ~/Downloads/<theme>-sandbox), unless the theme's GOALS.md records an explicit user preference otherwise
- Never teach version-specific behavior from memory — verify against docs first and teach with the source named
- Never skip the intake interview because goals seem obvious — the interview also produces the mission and the promote/demote decisions
- Never start new units before the opening review quiz — retention comes first
- Never let ZPD reasoning reorder, insert, or drop units mid-theme — the unit list changes only by explicit user decision recorded in GOALS.md
- Never promote a term to the NOTES.md Terms section on exposure alone — only demonstrated correct use qualifies
- Session mode is fixed per theme at intake (tool vs concept) — don't drift between modes mid-theme
- Fluency is not mastery: in-session smoothness never replaces next-session delayed recall as the evidence of learning

## Verification
1. Theme dir contains GOALS.md (with Why / Success looks like / Constraints / Out of scope), PROGRESS.md, and NOTES.md (with a Terms section) before the first session ends
2. After each session, jj log in ai-mentor shows a described commit covering that session's changes
3. Tool-mode units: the user executed the commands themselves and the agent verified the resulting state (not just command output)
4. A fresh session reading only PROGRESS.md knows exactly which unit to continue with, what to review, and which quiz gaps must be re-checked
