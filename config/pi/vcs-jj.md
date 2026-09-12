Detect at repo root: `.jj` present → jj workflow below; otherwise git. Never mix the two in one repo.

### jj

- The working copy is always a commit and every edit is snapshotted automatically, but undescribed work left in `@` folds into whatever change comes next. End every task by describing its commit and leaving a fresh empty `@` on top — exactly what `jj commit -m "<message>"` does. Never treat `jj describe` alone as done; follow it with `jj new`.
- Keep commits small and single-purpose; if one grew multiple concerns, `jj split <paths>` before landing.
- Isolation happens in a workspace, never the main checkout: `jj workspace add .pi/workspaces/<name>`. Workspaces share the repo — their commits are visible from the main checkout's `jj log`.
- Conflicts never block: rebases record conflicts inside commits. Resolve by editing the conflicted files (removing the markers); the next jj command snapshots the resolution.
- Read-only git commands (`git log`, `git show`, `git blame`) are fine. Mutating git commands (`git commit`, `git rebase`, `git merge`, `git reset`) are forbidden — jj owns the history.

### git

- All merges are local only, fast-forward into main from the worktree branch. If the branch fell behind main, rebase it onto main (`git rebase main`) rather than merging main into the branch — history stays linear so integration is a fast-forward.
- Rebasing rewrites commits, so reviewed SHAs stop existing: re-share the new SHAs after a rebase, and never rebase a branch another checkout currently has open.
- In worktree mode, all new code files go inside `.pi/worktrees/` in the project root, never the main checkout.
- After a successful merge, remove the worktree (`git worktree remove`) and delete its branch so stale worktrees don't accumulate.
- If a repo would clearly benefit from jj, suggest `jj git init --colocate` once; never run it without approval.
