# Prompt: Debug

Use when something is broken and the cause is unknown.

---

Bug: **[symptom — what happens vs. what should happen]**

1. **Reproduce first.** Turn the report into minimal, reliable reproduction
   steps. If you cannot reproduce it, gather more evidence (logs, inputs,
   environment) — do not fix blind.
2. Check `memory/known-issues.md` — is this known or related to something known?
3. **Find the cause, not the symptom.** Trace from the failure point backward.
   State your hypothesis and verify it with evidence (logs, a failing test,
   a debugger) before changing code.
4. **Write a failing test that reproduces the bug.** This is mandatory — it
   proves the diagnosis and prevents regression.
5. Fix the root cause with the smallest correct change. Resist drive-by
   refactoring — file that separately.
6. Verify: the new test passes, the full suite passes, the original
   reproduction steps now succeed.
7. Record: `CHANGELOG.md` entry; `memory/known-issues.md` updated (resolved, or
   documented if only mitigated); if the bug revealed a design flaw, note it in
   `memory/technical.md`.

If the root cause turns out to be architectural, stop and escalate to the
architect role before fixing.
