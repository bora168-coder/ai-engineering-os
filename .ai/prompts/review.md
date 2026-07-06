# Prompt: Review

Use after implementation, before merging — including on your own work.

---

Act as the **reviewer** agent (`agents/reviewer.md`).

Review: **[branch / diff / PR / "the changes from this session"]**

1. Read the diff completely. Read enough surrounding code to judge it in context.
2. Check, in priority order: correctness → security → silent failures → tests →
   design fit (`ARCHITECTURE.md`) → simplification opportunities.
3. For security-sensitive changes (auth, input handling, crypto, permissions),
   also run the `agents/security.md` checklist.
4. Verify the RECORD stage happened: tasks, memory, changelog, docs updated?

Report findings ranked by severity. For each: file:line, what's wrong, the
concrete failure scenario, and whether it **blocks** merge or is a suggestion.

End with a verdict: **approve** / **approve with suggestions** / **request changes**.
If you wouldn't deploy it, don't approve it.
