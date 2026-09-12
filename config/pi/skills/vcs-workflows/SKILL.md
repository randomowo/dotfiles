---
name: vcs-workflows
description: Procedural half of the VCS rules in AGENTS.md — landing jj workspace or git worktree work after approval, creating and cleaning up workspaces/worktrees, resolving jj conflicts, undoing jj operations, and the jj command cheat sheet.
---

## When to Use

- Landing approved isolated work — a jj workspace head or a git worktree branch — into the default bookmark / main.
- Creating or cleaning up a jj workspace or git worktree.
- Resolving conflicts recorded inside jj commits.
- Undoing a jj operation.

Rules of engagement (never push, ask before remotes, isolation asks, commit discipline) live in AGENTS.md; this skill carries only procedures.

## Procedure

### jj: create a workspace

1. `jj workspace add .pi/workspaces/<name>` — isolation never happens in the main checkout.
2. The workspace shares the repo; its commits are visible from the main checkout's `jj log`.

### jj: land a workspace (after explicit approval)

1. Note the workspace head's change ID from `jj log`.
2. `jj rebase -r <head> -d <default bookmark>`.
   Rebase gives the head a NEW change ID — capture the rebased ID from the command output; the old one is abandoned.
3. `jj bookmark move <default bookmark> --to <rebased head>` — never point this at the pre-rebase ID.
4. From the main workspace, `jj rebase -r @ -d <default bookmark>` so the main working copy sits on the landed history.
5. `jj workspace forget <name>`, then remove the workspace directory.

### jj: undo

- `jj op log` to inspect past operations, `jj op restore <op-id>` to undo one.

### git: create a worktree

1. Create from latest local main (`git fetch` not required); if the branch was cut from a stale ref, rebase it onto main.
2. All new code files go inside `.pi/worktrees/` in the project root, never the main checkout.

### git: land a worktree (after explicit approval)

1. From the main checkout: `git merge --ff-only <branch>`.
2. Verify the main checkout's working tree is clean.
3. `git worktree remove <path>` and delete the branch.

### Resolve jj conflicts

Conflicts never block: rebases record conflicts inside commits. Edit the conflicted files to remove the conflict markers; the next jj command snapshots the resolution.

## Cheat sheet

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
| workspace add / list | `jj workspace add <path>` / `jj workspace list` |

`jj describe` alone never ends a task — follow it with `jj new`, or just use `jj commit`.

## Pitfalls

- After `jj rebase -r`, the old change ID is abandoned; `jj bookmark move --to` must target the rebased head.
- Never rebase a git branch another checkout currently has open.
- In jj repos, never run mutating git commands (`git commit`, `git rebase`, `git merge`, `git reset`).

## Verification

- Landing done: `jj log` (or `git log`) shows the isolated head on the default bookmark/main, and the workspace/worktree directory is gone.
- Undo done: `jj log` reflects the restored operation.
