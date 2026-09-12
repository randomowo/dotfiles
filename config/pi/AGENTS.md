# Global preferences

- No proactive comments. Code self-explanatory; comment only for something locally unintuitive to codebase newcomer, 1-2 lines, jargon-free. Long comments go stale.
- Spec/plan/design docs never committed: write to temp dir outside repo, share path in chat. No stray markdown files in codebase.
- Never write backwards-compatible logic (shims, deprecated-path handling). Assume no users ran code, unreleased; old/new data compatibility belongs in migrations, not logic.
- Commit every change small, atomic — full history exists, any change revertible. Overrides default "only commit when asked" behavior.

## File Operations

- Use pi's native `read`, `edit`, `write` tools for file read/edit/write.
- No `cat`, `head`, `tail`, `less`, `sed`, `awk`, `tee`, `echo >`, `printf >`, `cat >>` for file reading/writing unless task needs shell processing (piping into another command, `tail -f`, `sudo tee`, or flag native tool lacks).
- Appending = edit: use `edit` (or `write` for new file), never `cat` heredoc.
- `rg`, `find`, `grep`, `ls` via `bash` tool preferred for file discovery/search.
- Use `bash` for tests, builds, Git, jj, Docker, other executables.

## Version Control

Isolation, common to both workflows:

- Before non-trivial edits, ask once per task: commits in main checkout, or separate workspace (jj) / worktree (git)? Default commits when user can't be asked (background run).
- Simple edits (typo, one-line tweak, config value): never ask — commit directly in main checkout.
- User picks isolation: comply, no pushback. Recommend when work experimental or parallel, long-running, or user wants main checkout clean.
- Landing isolated work needs explicit approval first.
- Landing, cleanup, conflict-resolution, undo procedures + jj cheat sheet: use `vcs-workflows` skill.

Commit messages, common to both workflows:

- Title under 80 chars; 120 hard limit.

Remotes, common to both workflows:

- NEVER push — no `git push`, `jj git push`, or other push command.
- Ask before any remote-touching command (`fetch`, `fetch --prune`, remote ref updates).

### git

- Merges local only, fast-forward into main from worktree branch. Branch behind main: rebase onto main (`git rebase main`), not merge main into branch — history linear, integration fast-forward.
- Rebase rewrites commits, reviewed SHAs stop existing: re-share new SHAs after rebase; never rebase branch another checkout has open.
- Worktree mode: new code files go in `.pi/worktrees/` in project root, never main checkout.
- After successful merge: remove worktree (`git worktree remove`), delete branch — no stale worktrees.