# Prompt: Research

Use when a decision needs evidence: choosing a library, service, pattern, or approach.

---

Act as the **researcher** agent (`agents/researcher.md`).

Research question: **[state it precisely]**
Decision criteria: **[e.g. cost, maturity, performance, license, fit with TECH_STACK.md]**

1. Confirm the question and criteria; sharpen them if vague.
2. Identify 2–4 realistic options. Include "build minimal version ourselves"
   and "do nothing" if plausible.
3. For each option verify against current sources (not memory): maturity,
   maintenance activity, license, cost, integration effort with our stack.
4. Produce a comparison table against the criteria.
5. Recommend one option. State the strongest argument **against** your
   recommendation and why it doesn't win.
6. Record: findings worth keeping → `memory/technical.md`; if this decides
   architecture → draft an ADR from `templates/adr.md`.

Do not implement anything. Research ends with a recommendation awaiting approval.
