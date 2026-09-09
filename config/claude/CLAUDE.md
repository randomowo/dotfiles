# Global preferences

- Do not proactively write comments in code. We prefer code to be self explanatory. When we write comments its because there is something locally unintuitive that a future reader should know. But as we write code our goal is to make all code locally intuitive, removing the need for comments. If we ever do need to write comments, we never introduce jargon. Comments should be understandable to someone who was just dropped into the codebase for the first time. Comments should attempt to be concise, on average 1-2 lines. If you are writing a longer comment its likely there is a lot of useless information, which is bad because the information may become stale as the code changes
- Do not leave random markdown files in the codebase that are meant to be some way to deliver information to me. If you want to write a markdown file write it in a temporary file, and give me the path and chat and I can read it
- Never write code that is explicitly backwards compatible. Systems should handle backwards compatibility (like migrations), not logic. If there is some logic that needs to be written otherwise it would appear it would break older users, you MUST make the assumption that no users have ran that code yet and its unreleased, so it would not make sense to consider the side effects that code would produce. This is a safe assumption because the maintainers of this codebase always ensure code that gets shipped is compatbile with the systems that allow for us to not have to explicitly hardcode backwards compatibility
- Commit every change (small, atomic commits) so full history exists and any change can be reverted. Overrides default "only commit when asked" behavior.

## File Operations

- Use Claude Code's native `Read`, `Edit`, and `Write` tools for reading, editing, and writing files. If one is missing from the toolset it is deferred, not absent — load it with `ToolSearch("select:Read,Edit,Write")` rather than falling back to the shell.
- Do not use `cat`, `head`, `tail`, `less`, `sed`, `awk`, `tee`, `echo >`, `printf >`, or `cat >>` for file reading and writing unless the task explicitly requires shell processing (piping into another command, `tail -f`, `sudo tee`, or a flag the native tool has no equivalent for).
- Appending to a file is an edit: use `Edit` (or `Write` for a new file), never `cat >> file` or a `cat` heredoc.
- `Glob` and `Grep` are preferred for file discovery and search, but are not present in every session — `ls`, `find`, and `grep`/`rg` are acceptable fallbacks when they are missing.
- Use Bash for tests, builds, Git, Docker, and other executable commands.

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

## Git Rules

- NEVER push to origin. All merges are local only (fast-forward into main from the worktree branch).
- If a worktree branch has fallen behind main, rebase it onto main (`git rebase main`), do not merge main into the branch. Keeps branch history linear so integration stays a fast-forward.
- Rebasing rewrites the branch's commits, so any reviewed SHAs stop existing. Re-share the new SHAs after a rebase, and never rebase a branch another checkout currently has open.
- When worktree work is done, ask for approval first. Only after explicit approval, merge locally into main with `git merge --ff-only` and verify the main checkout's working tree is clean afterwards.
- After a successful merge, remove the worktree (`git worktree remove`) and delete its branch so stale worktrees don't accumulate.
- Ask before any command that touches a remote (fetch, fetch --prune, remote ref updates); push is already forbidden outright.

## Worktrees

- If project git inited: edit code in separate git worktree, not main checkout.
- Always create worktrees from latest local main (`git fetch` not required; rebase onto main if branch cut from stale ref).
- All new code files go inside worktree dir (`.claude/worktrees` inside project root), never main checkout. Spec, plan, and design docs go in a temp dir outside the repo (path shared in chat), so they are never committed or merged into main.
