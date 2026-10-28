# 🌟 VOID AI OS

**An engineering operating system for AI-assisted software development.**

This is a GitHub Template Repository. Every project you start from it ships with a
complete engineering workflow that AI assistants (Claude Code first, others later)
understand instantly: project rules, architecture docs, agent role definitions,
reusable prompts, persistent memory, and task tracking — all under version control.

> One clone. One instruction. The AI works like a senior engineer on a production project.

---

## Quick start

### 1. Create a project from this template

```bash
gh repo create my-project --template bora168-coder/ai-engineering-os --private --clone
cd my-project
```

Or clone directly:

```bash
git clone https://github.com/bora168-coder/ai-engineering-os my-project
cd my-project
```

### 2. Initialize it

```bash
./scripts/init.sh
```

This asks for your project name and description, fills in all `{{PLACEHOLDER}}`
tokens, and resets memory/tasks to a clean state.

### 3. Open Claude Code

```bash
claude
```

That's it. `CLAUDE.md` at the repo root is loaded automatically and instructs
Claude to start in **Compact mode** (token-efficient by default): read
`.ai/README.md`, then lazy-load only task-relevant files. If you use a different
assistant, start with:

```
Read .ai/README.md. Use compact mode and load only files needed for the task.
```

---

## What's inside

```
.ai/                  The brain — everything the AI must know
├── README.md         Boot sequence: what to read, in what order, and the operating rules
├── PROJECT.md        What this project is and why it exists
├── ARCHITECTURE.md   System design and structure
├── TECH_STACK.md     Languages, frameworks, tooling, versions
├── WORKFLOW.md       How work flows: plan → implement → review → document
├── RULES.md          Non-negotiable engineering rules
├── STYLE_GUIDE.md    Code style and conventions
├── TESTING.md        Testing strategy and requirements
├── SECURITY.md       Security requirements and practices
├── ROADMAP.md        Where the project is going
├── DECISIONS.md      Log of architectural decisions (ADR index)
├── agents/           14 role definitions (architect, backend, reviewer, QA, …)
├── prompts/          Reusable prompts for common workflows (implement, debug, release, …)
├── memory/           Persistent knowledge: business, technical, decisions, issues, glossary
└── tasks/            Backlog, current sprint, todo, completed

templates/            Document templates: ADR, feature request, bug report, story, …
docs/                 Human-facing documentation (architecture, API, deployment, guides)
scripts/              init.sh (project setup) and validate.sh (structure check)
examples/             Example projects built with this OS
.github/workflows/    CI that validates the OS structure stays intact
```

## Compact vs Full workflow

### Compact mode (default, recommended)

- Reads only minimal instructions first.
- Loads prompts/agents/memory/docs only when task-relevant.
- Best for everyday bug fixes, features, and docs updates.

### Full workflow mode (opt-in)

Use this when work is large, high-risk, or explicitly requested:

```
Use full workflow mode. Follow .ai/FULL_WORKFLOW.md.
```

This preserves the deep process while avoiding unnecessary startup context on
small tasks.

### Before vs after (template behavior)

- **Before:** startup instructions encouraged broad `.ai/` preloading each session.
- **After:** startup defaults to compact lazy-loading and reads only task-relevant files.
- **When needed:** users can explicitly switch to full mode for large/high-risk work.

## The operating loop

Every task follows the same loop, enforced by `.ai/WORKFLOW.md`:

1. **Understand** — read project state, memory, and current sprint.
2. **Plan** — write an implementation plan before touching code.
3. **Implement** — small, reviewable increments following the rules.
4. **Verify** — tests pass, behavior confirmed.
5. **Record** — update docs, memory, roadmap, changelog, and sprint. Always.

Step 5 is what makes this an OS instead of a prompt: the project's knowledge
compounds. In compact mode, update only files made stale by the completed task.
For high-risk work, switch to full mode to run the complete workflow.

## Roadmap

- **v1.0** — AI workflow, project rules, agent definitions, templates, documentation structure. *(you are here)*
- **v2.0** — Scripts to initialize new projects, validate documentation, and automate setup.
- **v3.0** — Support for multiple AI assistants (Claude, ChatGPT, Gemini, …) with provider-specific instructions.
- **v4.0** — Optional integrations with issue tracking, documentation tools, and CI/CD.

## License

[MIT](LICENSE)
