### git

- All merges are local only, fast-forward into main from the worktree branch. If the branch fell behind main, rebase it onto main (`git rebase main`) rather than merging main into the branch — history stays linear so integration is a fast-forward.
- Rebasing rewrites commits, so reviewed SHAs stop existing: re-share the new SHAs after a rebase, and never rebase a branch another checkout currently has open.
- In worktree mode, all new code files go inside `.claude/worktrees/` in the project root, never the main checkout.
- After a successful merge, remove the worktree (`git worktree remove`) and delete its branch so stale worktrees don't accumulate.
