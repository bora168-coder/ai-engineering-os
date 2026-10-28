# Provider: GitHub Copilot

**Entry file:** `.github/copilot-instructions.md` — added automatically to
Copilot Chat requests in this repository and read by the Copilot coding agent.

## How it loads context

- The entry file is short on purpose. Copilot does not always open referenced
  files on its own, so **agent mode** and the **coding agent** must read
  `.ai/README.md` and follow its boot sequence before working.
- In plain chat or inline completions, Copilot only sees the entry file and
  the open files. For bigger tasks, attach `.ai/README.md`, `.ai/RULES.md`,
  and the relevant memory files to the chat.

## Capabilities

- Agent mode and the coding agent can edit files and run commands; they must
  complete the full workflow, including the RECORD stage.
- Inline completions cannot follow a workflow. Treat them as typing help only.

## Tool-specific notes

- The coding agent works through pull requests. Put the plan in the PR
  description and the RECORD-stage updates in the same PR.
