# 🌟 VOID AI OS

**An engineering operating system for AI-assisted software development.**

This is a GitHub Template Repository. Every project you start from it ships with a
complete engineering workflow that AI assistants
understand instantly: project rules, architecture docs, agent role definitions,
reusable prompts, persistent memory, and task tracking — all under version control.

Works with **Claude Code, OpenAI Codex / ChatGPT, Gemini CLI, GitHub Copilot, and
Cursor**. Every assistant shares the same `.ai/` brain.

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

### 3. Open your AI assistant

Each assistant auto-loads its own entry file. Every entry file sends it to
`.ai/README.md`, so all assistants follow the same workflow.

| Assistant | Entry file (loaded automatically) |
|---|---|
| Claude Code | `CLAUDE.md` |
| OpenAI Codex | `AGENTS.md` |
| Gemini CLI | `GEMINI.md` |
| GitHub Copilot | `.github/copilot-instructions.md` |
| Cursor | `.cursor/rules/void-ai-os.mdc` |
| ChatGPT (web) | none — see `.ai/providers/chatgpt.md` for the upload-and-diff setup |

For example, with Claude Code:

```bash
claude
```

Using a different assistant? Start the session with:

```
Read .ai/README.md. Follow every instruction. Continue from the current project state.
```

Tool-specific notes, and how to add or remove an assistant, are in
`.ai/providers/README.md`.

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
├── tasks/            Backlog, current sprint, todo, completed
└── providers/        Per-assistant notes (Claude, ChatGPT/Codex, Gemini, Copilot, Cursor)

CLAUDE.md             Entry file for Claude Code    ┐
AGENTS.md             Entry file for OpenAI Codex   │ one per assistant,
GEMINI.md             Entry file for Gemini CLI     │ all point to .ai/
.github/copilot-instructions.md  Copilot            │
.cursor/rules/void-ai-os.mdc     Cursor             ┘

templates/            Document templates: ADR, feature request, bug report, story, …
docs/                 Human-facing documentation (architecture, API, deployment, guides)
scripts/              init.sh (project setup) and validate.sh (structure check)
examples/             Example projects built with this OS
.github/workflows/    CI that validates the OS structure stays intact
```

## The operating loop

Every task follows the same loop, enforced by `.ai/WORKFLOW.md`:

1. **Understand** — read project state, memory, and current sprint.
2. **Plan** — write an implementation plan before touching code.
3. **Implement** — small, reviewable increments following the rules.
4. **Verify** — tests pass, behavior confirmed.
5. **Record** — update docs, memory, roadmap, changelog, and sprint. Always.

Step 5 is what makes this an OS instead of a prompt: the project's knowledge
compounds. Next session — or next year — the AI picks up exactly where it left off.

## Roadmap

- **v1.0** — AI workflow, project rules, agent definitions, templates, documentation structure.
- **v2.0** — Scripts to initialize new projects, validate documentation, and automate setup.
- **v3.0** — Support for multiple AI assistants (Claude, ChatGPT, Gemini, …) with provider-specific instructions. *(you are here)*
- **v4.0** — Optional integrations with issue tracking, documentation tools, and CI/CD.

## License

[MIT](LICENSE)
