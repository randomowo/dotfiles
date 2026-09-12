# Global preferences

- No proactive comments. Code self-explanatory. Comment only if locally unintuitive to codebase newcomer — 1-2 lines, jargon-free. Long comments go stale.
- Never commit spec/plan/design docs. Write to temp dir outside repo, share path in chat. No stray markdown files in codebase either.
- No backwards-compat logic (shims, deprecated-path handling). Assume unreleased, no users. Old/new data compat belongs in migrations, not logic.
- Commit every change small + atomic — full history, any change revertible. Overrides default "only commit when asked".

## File Operations

- Use native `Read`, `Edit`, `Write` tools for file work. Missing = deferred, not absent — load via `ToolSearch("select:Read,Edit,Write")`, don't fall back to shell.
- No `cat`, `head`, `tail`, `less`, `sed`, `awk`, `tee`, `echo >`, `printf >`, `cat >>` for file read/write unless task needs shell processing (pipe into command, `tail -f`, `sudo tee`, flag native tool lacks).
- Append = edit: `Edit` (or `Write` for new file), never `cat` heredoc.
- Prefer `Glob`/`Grep` for discovery + search when present; `ls`, `find`, `rg`/`grep` fallbacks.
- `Bash` for tests, builds, Git, jj, Docker, other executables.

## Subagent Delegation

- 2+ separable tasks → delegate to subagents, not all inline.
- No shared state + no ordering → dispatch parallel: all Agent/Task calls in one message.
- Dependent tasks sequential: wait for producer result, then dispatch consumer.
- Orchestrate in main thread: split work, one self-contained prompt per subagent (goal, files, expected output), merge results yourself.
- Inline instead when: single edit, one-file lookup, or split costs more than doing.
- Subagents run one tier below main thread (Fable→Opus, Opus→Sonnet, Sonnet→Haiku) where category rules below allow. Where they don't (review never Haiku, deep reasoning never Sonnet), category rule wins, tier stays.
- Never Fable without explicit user approval; never Fable as subagent — top subagent tier is Opus.

## Subagent Selection

Every Agent/Task call.

**Model tier** — pick by category, not case-by-case. Same category = same tier every time in session (never one review Haiku, another Sonnet):
  - Opus: planning, orchestrating multiple agents, hard architectural review, deep multi-step reasoning.
  - Sonnet: default. Hard implementation (unclear/unknown issues, new subapp planning, domain from zero) + all code/diff review — review needs judgment, never Haiku.
  - Haiku: small/easy only — spec given, code search, mechanical single-file edits (typo, rename, format-preserving tweak).

**subagent_type** — match task shape to most specific agent; don't default to general-purpose when narrower match exists:
  - read-only search/locate code → most specific locate-only agent available, else general-purpose
  - bounded 1-2 file mechanical edit → most specific surgical-edit agent available, else general-purpose
  - diff/PR/branch review → most specific review agent available, else general-purpose
  - multi-file/open-ended/unclear scope → general-purpose (or planning agent if task is to plan, not do)
  - never force narrow agent past its stated scope — escalate to general-purpose
  - tier rules override any model in agent's own definition — always pass model explicitly per tier rules above

## Version Control

Isolation, both workflows:

- Before non-trivial edits, ask once per task: commits in main checkout, or separate workspace (jj) / worktree (git)? Default to commits when user can't be asked (background run).
- Simple edits (typo, one-line tweak, config value): never ask — commit in main checkout.
- User picks isolation → comply, no pushback. Recommend when experimental/parallel, long-running, or user wants main checkout clean.
- Landing isolated work needs explicit approval first.
- Landing, cleanup, conflict-resolution, undo procedures + jj cheat sheet: use `vcs-workflows` skill.

Commit messages, both workflows:

- Title under 80 chars; 120 hard limit.

Remotes, both workflows:

- NEVER push — no `git push`, `jj git push`, any other push command.
- Ask before any remote-touching command (`fetch`, `fetch --prune`, remote ref updates).

### git

- Merges local only, fast-forward into main from worktree branch. Branch behind main → rebase onto main (`git rebase main`), never merge main into branch — history stays linear, integration = fast-forward.
- Rebase rewrites commits, reviewed SHAs die: re-share new SHAs after rebase; never rebase branch another checkout has open.
- Worktree mode: new code files go in `.claude/worktrees/` in project root, never main checkout.
- After successful merge, remove worktree (`git worktree remove`) + delete its branch — no stale worktrees.

@~/.claude/vcs.md