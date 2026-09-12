Detect at repo root: `.jj` present → jj rules below; otherwise the git workflow above. Never mix the two in one repo.

### jj

- The working copy is always a commit and every edit is snapshotted automatically, but undescribed work left in `@` folds into whatever change comes next. End every task by describing its commit and leaving a fresh empty `@` on top — exactly what `jj commit -m "<message>"` does. Never treat `jj describe` alone as done; follow it with `jj new`.
- Keep commits small and single-purpose; if one grew multiple concerns, `jj split <paths>` before landing.
- Isolation happens in a workspace, never the main checkout: `jj workspace add .pi/workspaces/<name>`. Workspaces share the repo — their commits are visible from the main checkout's `jj log`.
- Conflicts never block: rebases record conflicts inside commits. Resolve by editing the conflicted files (removing the markers); the next jj command snapshots the resolution.
- Read-only git commands (`git log`, `git show`, `git blame`) are fine. Mutating git commands (`git commit`, `git rebase`, `git merge`, `git reset`) are forbidden — jj owns the history.
- If a repo would clearly benefit from jj, suggest `jj git init --colocate` once; never run it without approval.
