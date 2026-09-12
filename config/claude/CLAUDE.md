# Global preferences

- Do not write comments proactively. Code should be self explanatory; write a comment only for something locally unintuitive to a reader new to the codebase, and keep it 1-2 lines and jargon-free. Long comments go stale as the code changes.
- Spec, plan, and design docs are never committed: write them to a temp dir outside the repo and share the path in chat. No other stray markdown files in the codebase either.
- Never write backwards-compatible logic (shims, deprecated-path handling). Assume no users have run the code and it is unreleased; compatibility between old and new data belongs in systems like migrations, not in logic.
- Commit every change in small, atomic commits so full history exists and any change can be reverted. Overrides the default "only commit when asked" behavior.

## File Operations

- Use Claude Code's native `Read`, `Edit`, and `Write` tools for reading, editing, and writing files. If one is missing from the toolset it is deferred, not absent — load it with `ToolSearch("select:Read,Edit,Write")` rather than falling back to the shell.
- Do not use `cat`, `head`, `tail`, `less`, `sed`, `awk`, `tee`, `echo >`, `printf >`, or `cat >>` for file reading or writing unless the task explicitly requires shell processing (piping into another command, `tail -f`, `sudo tee`, or a flag the native tool has no equivalent for).
- Appending to a file is an edit: use `Edit` (or `Write` for a new file), never a `cat` heredoc.
- `Glob` and `Grep` are preferred for file discovery and search when present; `ls`, `find`, and `rg`/`grep` are acceptable fallbacks.
- Use `Bash` for tests, builds, Git, jj, Docker, and other executable commands.

## Subagent Delegation

- When a request contains 2 or more separable tasks, delegate them to subagents instead of doing them all inline.
- Tasks that share no state and have no ordering dependency must be dispatched in parallel — put every Agent/Task call in a single message so they run concurrently.
- Tasks with a dependency run in sequence: wait for the producer's result, then dispatch the consumer.
- Keep orchestration in the main thread: split the work, write one self-contained prompt per subagent (goal, files, expected output), then merge the results yourself.
- Do it inline instead when the whole job is a single edit, a one-file lookup, or when splitting it would cost more than doing it.
- Subagents run one model tier below the main thread — main Fable dispatches Opus, main Opus dispatches Sonnet, main Sonnet dispatches Haiku — as long as the task category rules below allow that tier. Where they don't (review never drops to Haiku, deep reasoning never drops to Sonnet), the category rule wins and the tier stays.
- Never use Fable without explicit user approval, and never run Fable as a subagent — the highest subagent tier is Opus.

## Subagent Selection

Applies to every Agent/Task tool call.

**Model tier** — pick by task category, not case by case. Same category must get the same tier every time within a session (never split e.g. one review on Haiku, another on Sonnet):
  - Opus: planning, orchestrating multiple agents, hard architectural review, any task needing deep multi-step reasoning.
  - Sonnet: default tier. Hard implementation work (unclear/unknown issues, new subapp planning, domain built from zero) and all code/diff review — review needs judgment, never downgrade it to Haiku.
  - Haiku: small/easy tasks only — spec already given, code search, mechanical single-file edits (typo, rename, format-preserving tweak).

**subagent_type** — match task shape to the most specific agent available, don't default to general-purpose when a narrower match exists:
  - read-only search/locate code → most specific locate-only agent available, else general-purpose
  - bounded 1-2 file mechanical edit → most specific surgical-edit agent available, else general-purpose
  - diff/PR/branch review → most specific review agent available, else general-purpose
  - multi-file/open-ended/unclear scope → general-purpose (or a planning agent if the task is to plan, not do)
  - never force a narrow agent onto a task that exceeds its stated scope — escalate to general-purpose instead
  - these tier rules override any model set in an agent's own definition — always pass the model explicitly per the tier rules above

## Version Control

Isolation, common to both workflows:

- Before non-trivial edits, ask once per task: commits in the main checkout, or a separate workspace (jj) / worktree (git)? Default to commits when the user can't be asked (background run).
- Simple edits (typo, one-line tweak, config value) never ask — commit directly in the main checkout.
- If the user picks isolation, comply without pushback. Recommend it when work is experimental or parallel, long-running, or the user may want the main checkout kept clean.
- Landing isolated work requires explicit approval first.
- For landing, cleanup, conflict-resolution, and undo procedures, plus the jj cheat sheet, use the `vcs-workflows` skill.

Commit messages, common to both workflows:

- The title should stay under 80 characters; 120 is the hard limit.

Remotes, common to both workflows:

- NEVER push — no `git push`, `jj git push`, or any other push command.
- Ask before any command that touches a remote (`fetch`, `fetch --prune`, remote ref updates).

@~/.claude/vcs.md
