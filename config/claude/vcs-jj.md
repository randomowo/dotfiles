Detect at repo root: `.jj` present → jj rules below; else git workflow above. Never mix two in one repo.

### jj

- Working copy always a commit, every edit snapshotted automatically, but undescribed work left in `@` folds into next change. End every task by describing commit + leaving fresh empty `@` on top — exactly what `jj commit -m "<message>"` does. Never treat `jj describe` alone as done; follow with `jj new`.
- Keep commits small, single-purpose; if one grew multiple concerns, `jj split <paths>` before landing.
- Isolation in workspace, never main checkout: `jj workspace add .claude/workspaces/<name>`. Workspaces share repo — commits visible from main checkout's `jj log`.
- Conflicts never block: rebases record conflicts inside commits. Resolve by editing conflicted files (remove markers); next jj command snapshots resolution.
- Read-only git commands (`git log`, `git show`, `git blame`) fine. Mutating git commands (`git commit`, `git rebase`, `git merge`, `git reset`) forbidden — jj owns history.
- If repo clearly benefits from jj, suggest `jj git init --colocate` once; never run without approval.