# Global preferences

- Do not proactively write comments in code. We prefer code to be self explanatory. When we write comments its because there is something locally unintuitive that a future reader should know. But as we write code our goal is to make all code locally intuitive, removing the need for comments. If we ever do need to write comments, we never introduce jargon. Comments should be understandable to someone who was just dropped into the codebase for the first time. Comments should attempt to be concise, on average 1-2 lines. If you are writing a longer comment its likely there is a lot of useless information, which is bad because the information may become stale as the code changes
- Do not leave random markdown files in the codebase that are meant to be some way to deliver information to me. If you want to write a markdown file write it in a temporary file, and give me the path and chat and I can read it
- Never write code that is explicitly backwards compatible. Systems should handle backwards compatibility (like migrations), not logic. If there is some logic that needs to be written otherwise it would appear it would break older users, you MUST make the assumption that no users have ran that code yet and its unreleased, so it would not make sense to consider the side effects that code would produce. This is a safe assumption because the maintainers of this codebase always ensure code that gets shipped is compatbile with the systems that allow for us to not have to explicitly hardcode backwards compatibility
- Commit every change (small, atomic commits) so full history exists and any change can be reverted. Overrides default "only commit when asked" behavior.
- Spec, plan, and design docs go in a temp dir outside the repo (path shared in chat), so they are never committed or merged into main.

## File Operations

- Use pi's native `read`, `edit`, and `write` tools for reading, editing, and writing files.
- Do not use `cat`, `head`, `tail`, `less`, `sed`, `awk`, `tee`, `echo >`, `printf >`, or `cat >>` for file reading and writing unless the task explicitly requires shell processing (piping into another command, `tail -f`, `sudo tee`, or a flag the native tool has no equivalent for).
- Appending to a file is an edit: use `edit` (or `write` for a new file), never `cat >> file` or a `cat` heredoc.
- `rg`, `find`, `grep`, and `ls` via the `bash` tool are the preferred means of file discovery and search.
- Use `bash` for tests, builds, Git, Docker, and other executable commands.

## Version Control

Detect at repo root: `.jj` present → jj workflow below. No `.jj` → git workflow below. Never mix the two in one repo.

### jj

The working copy is always a commit and every edit is snapshotted automatically, but that alone is not a checkpoint: undescribed work left in `@` gets folded into whatever change comes next. Ending a task means describing its commit and leaving a fresh empty `@` on top, which is exactly what `jj commit -m "<message>"` does — never end a task or session with undescribed changes sitting in `@`, and never treat `jj describe` alone as done (follow it with `jj new`, or just use `jj commit`). Keep commits small and single-purpose; if one commit grew multiple concerns, `jj split <paths>` before landing.

Workspaces:

- Before non-trivial edits, ask the user once per task: apply the work as commits in the main checkout, or in a separate workspace? Default to commits when the user can't be asked (background run).
- Simple edits (a single trivial file change: typo, one-line tweak, config value) never ask and never create a workspace — commit directly.
- If the user picks commits for workspace-sized work, comply without pushback.
- Recommend a workspace when the work is experimental or parallel, long-running, or the user may want the main checkout kept clean.
- Workspace work happens in a separate workspace, not the main checkout: `jj workspace add .pi/workspaces/<name>`.
- Workspaces share the repo; the workspace's commits are visible from the main checkout's `jj log`.
- To land finished work after explicit approval: `jj rebase -r <workspace head> -d <default bookmark>`, then `jj bookmark move <default bookmark> --to <workspace head>`, then from the main workspace `jj rebase -r @ -d <default bookmark>` so the main working copy sits on the landed history.
- Clean up after landing: `jj workspace forget <name>` and remove the directory.

Conflicts never block: rebases record conflicts inside commits. Resolve by editing the conflicted files (remove the conflict markers); the next jj command snapshots the resolution.

Remotes:

- NEVER run `jj git push` or any other push command.
- Ask before `jj git fetch` or any command that touches a remote.
- Read-only git commands (`git log`, `git show`, `git blame`) are fine. Mutating git commands (`git commit`, `git rebase`, `git merge`, `git reset`) are forbidden in jj repos; jj owns the history.

Mistake recovery: `jj op log` to inspect past operations, `jj op restore <op-id>` to undo one.

Cheat sheet:

| goal | command |
| --- | --- |
| describe working copy | `jj describe -m "msg"` |
| start next commit | `jj new` |
| describe + start next | `jj commit -m "msg"` |
| split a commit | `jj split <paths>` |
| rebase | `jj rebase -r <rev> -d <dest>` |
| advance branch | `jj bookmark move <name> --to <rev>` |
| history / status / diff | `jj log` / `jj st` / `jj diff` |
| undo | `jj op log`, `jj op restore <op>` |
| parallel workspace | `jj workspace add <path>`, `jj workspace list` |
| fetch (ask first) | `jj git fetch` |

### git

- NEVER push to origin. All merges are local only (fast-forward into main from the worktree branch).
- If a worktree branch has fallen behind main, rebase it onto main (`git rebase main`), do not merge main into the branch. Keeps branch history linear so integration stays a fast-forward.
- Rebasing rewrites the branch's commits, so any reviewed SHAs stop existing. Re-share the new SHAs after a rebase, and never rebase a branch another checkout currently has open.
- When worktree work is done, ask for approval first. Only after explicit approval, merge locally into main with `git merge --ff-only` and verify the main checkout's working tree is clean afterwards.
- After a successful merge, remove the worktree (`git worktree remove`) and delete its branch so stale worktrees don't accumulate.
- Ask before any command that touches a remote (fetch, fetch --prune, remote ref updates); push is already forbidden outright.
- If the repo would clearly benefit from jj, suggest `jj git init --colocate` once; never run it without approval.

Worktrees (git repos only):

- Before non-trivial edits, ask the user once per task: apply the work as commits in the main checkout, or in a separate git worktree? Default to commits when the user can't be asked (background run).
- Simple edits (a single trivial file change) never ask and never create a worktree — commit directly in the main checkout.
- If the user picks commits for worktree-sized work, comply without pushback.
- Recommend a worktree when the work is experimental or parallel, long-running, or the user may want the main checkout kept clean.
- If a worktree is chosen: create from latest local main (`git fetch` not required; rebase onto main if the branch was cut from a stale ref); all new code files go inside the worktree dir (`.pi/worktrees` inside project root), never the main checkout.
