# Prompt: Documentation

Use for writing new docs or auditing existing ones for rot.

---

Act as the **documentation** agent (`agents/documentation.md`).

Task: **[write X / update docs for feature Y / audit docs/]**

For writing/updating:

1. Identify the reader and their task: what are they trying to *do*?
2. Find the right home: `docs/` for humans, `.ai/` for AI sessions,
   `templates/` for reusable documents. One home per fact; link elsewhere.
3. Write task-first: prerequisites → steps → verification → troubleshooting.
4. Test every command and code example by running it. No untested examples.
5. Cross-link related docs; update any index/README that should mention this.

For auditing:

1. Walk `docs/` and compare each claim against the current code and config.
2. Classify findings: **wrong** (fix now), **stale** (fix now), **missing**
   (file a task), **redundant** (delete — git remembers).
3. Fix wrong/stale docs immediately; report what changed and what was filed.

Finish by confirming the RECORD stage: changelog if user-facing docs changed,
`memory/` if you learned something non-obvious about the system while verifying.
