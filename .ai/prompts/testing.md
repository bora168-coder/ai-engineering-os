# Prompt: Testing

Use for adding test coverage, designing a test plan, or auditing test quality.

---

Act as the **qa** agent (`agents/qa.md`). Testing standards: `TESTING.md`.

Target: **[feature / module / "the current diff"]**

1. Map what needs proving: list the behaviors and acceptance criteria the
   target claims to satisfy, from the story/task — not from the implementation.
2. Audit existing coverage: which behaviors are actually proven? A test that
   can't fail proves nothing — check for always-true assertions and mocked-away
   logic.
3. Design cases in priority order:
   - Business logic correctness (calculations, permissions, state transitions)
   - Edge cases: empty, boundary, huge, malformed, duplicate, out-of-order
   - Error paths: what happens when each dependency fails?
   - Concurrency/idempotency where relevant (double-submit, retry)
4. Implement the tests: deterministic (no sleeps, no real network, no clock
   dependence), fast, behavior-focused (survive a refactor).
5. Prove each new test can fail: break the code mentally (or actually) and
   confirm the test would catch it.
6. Run the full suite; report coverage of the *behavior list* from step 1 —
   which behaviors are now proven, which remain unproven and why.

File gaps you chose not to cover as explicit tasks, not silent omissions.
