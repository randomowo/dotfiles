# Global preferences

- Do not write comments proactively. Code should be self explanatory; write a comment only for something locally unintuitive to a reader new to the codebase, and keep it 1-2 lines and jargon-free. Long comments go stale as the code changes.
- Spec, plan, and design docs are never committed: write them to a temp dir outside the repo and share the path in chat. No other stray markdown files in the codebase either.
- Never write backwards-compatible logic (shims, deprecated-path handling). Assume no users have run the code and it is unreleased; compatibility between old and new data belongs in systems like migrations, not in logic.
- Commit every change in small, atomic commits so full history exists and any change can be reverted. Overrides the default "only commit when asked" behavior.

## File Operations

- Use pi's native `read`, `edit`, and `write` tools for reading, editing, and writing files.
- Do not use `cat`, `head`, `tail`, `less`, `sed`, `awk`, `tee`, `echo >`, `printf >`, or `cat >>` for file reading or writing unless the task explicitly requires shell processing (piping into another command, `tail -f`, `sudo tee`, or a flag the native tool has no equivalent for).
- Appending to a file is an edit: use `edit` (or `write` for a new file), never a `cat` heredoc.
- `rg`, `find`, `grep`, and `ls` via the `bash` tool are the preferred means of file discovery and search.
- Use `bash` for tests, builds, Git, jj, Docker, and other executable commands.

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
