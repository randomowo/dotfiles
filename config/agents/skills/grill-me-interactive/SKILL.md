---
name: grill-me-interactive
description: Grill the user relentlessly about a plan, decision, or idea, presenting each round as interactive multiple-choice questions. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrases.
---

Interview the user relentlessly until you reach a shared understanding. Map this as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask _now_ without guessing at answers you haven't heard yet.

## Facts are yours, decisions are theirs

When a frontier question needs a fact from the environment (filesystem, docs, tools), look it up yourself, directly or via a sub-agent. Never spend a question slot on anything you could look up. Don't block on it: a running exploration is an unsettled prerequisite, so only the questions downstream of it wait for the next round; ask the rest of the frontier now. The _decisions_ are the user's: put each to them and wait.

## Presenting a round

1. Post a normal chat message with the round's context: facts you established, constraints discovered, and one or two lines on why each question matters. Tool questions must stay short; this message carries the evidence.
2. Then ask the frontier in **one `ask_user_question` call**:
   - One tool question per decision, phrased concisely, ending in "?".
   - 2–4 options per question; the trade-offs go in option `description`s.
   - Your recommended answer is the **first option with "(Recommended)" appended to its label**.
   - Set `multiSelect: true` when answers aren't mutually exclusive.
   - Never author "Other" options — the free-text row is automatic. Mention in the chat message that custom answers are welcome.
3. The tool caps at 4 questions. If the frontier is bigger, ask the 4 **most upstream** questions (the ones other questions depend on) and say which decisions are deferred to the next round — downstream questions often become moot anyway. A question whose answer depends on another question still open this round belongs to a later round, not this one.
4. Wait for the answers before the next round. A user pressing Esc is abandoning the interview: stop grilling, summarize what settled so far.

Each round's answers reshape the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and repeat.

## Done

The session is done when the frontier is empty: every branch of the design tree visited, nothing left silently assumed. Before acting, post the complete design-tree summary — every settled decision, every explicitly dropped branch and why — and wait for the user to confirm the shared understanding. Do not act until they confirm.
