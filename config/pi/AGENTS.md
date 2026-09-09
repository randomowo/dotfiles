# Global preferences

- Do not proactively write comments in code. We prefer code to be self explanatory. When we write comments its because there is something locally unintuitive that a future reader should know. But as we write code our goal is to make all code locally intuitive, removing the need for comments. If we ever do need to write comments, we never introduce jargon. Comments should be understandable to someone who was just dropped into the codebase for the first time. Comments should attempt to be concise, on average 1-2 lines. If you are writing a longer comment its likely there is a lot of useless information, which is bad because the information may become stale as the code changes
- Do not leave random markdown files in the codebase that are meant to be some way to deliver information to me. If you want to write a markdown file write it in a temporary file, and give me the path and chat and I can read it
- Never write code that is explicitly backwards compatible. Systems should handle backwards compatibility (like migrations), not logic. If there is some logic that needs to be written otherwise it would appear it would break older users, you MUST make the assumption that no users have ran that code yet and its unreleased, so it would not make sense to consider the side effects that code would produce. This is a safe assumption because the maintainers of this codebase always ensure code that gets shipped is compatbile with the systems that allow for us to not have to explicitly hardcode backwards compatibility
- Commit every change (small, atomic commits) so full history exists and any change can be reverted. Overrides default "only commit when asked" behavior.

## File Operations

- Use pi's native `read`, `edit`, and `write` tools for reading, editing, and writing files.
- Do not use `cat`, `head`, `tail`, `less`, `sed`, `awk`, `tee`, `echo >`, `printf >`, or `cat >>` for file reading and writing unless the task explicitly requires shell processing (piping into another command, `tail -f`, `sudo tee`, or a flag the native tool has no equivalent for).
- Appending to a file is an edit: use `edit` (or `write` for a new file), never `cat >> file` or a `cat` heredoc.
- `rg`, `find`, `grep`, and `ls` via the `bash` tool are the preferred means of file discovery and search.
- Use `bash` for tests, builds, Git, Docker, and other executable commands.

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
- All new code files go inside the worktree dir (`.pi/worktrees` inside project root), never main checkout. Spec, plan, and design docs go in a temp dir outside the repo (path shared in chat), so they are never committed or merged into main.
