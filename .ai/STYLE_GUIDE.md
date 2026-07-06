# Style Guide

> Language-specific rules go here during project setup. These general rules apply always.

## Universal rules

- **Names say what things are.** No abbreviations that need decoding; no `data2`, `tmp`, `mgr`.
- **Functions do one thing.** If you need "and" to describe it, split it.
- **Comments explain *why*, never *what*.** If the code needs a *what* comment, rewrite the code.
- **Match the file you're in.** Existing local convention beats this guide; this guide beats personal taste.
- **Keep diffs minimal.** No drive-by reformatting or renaming in unrelated code.
- **Prefer boring code.** Clever one-liners lose to readable three-liners.

## Formatting

Formatting is automated — configure the formatter/linter in `TECH_STACK.md`
tooling and never hand-format. If a style debate can be settled by a tool
setting, settle it there once.

## Language-specific rules

_Add sections per language as the stack is chosen, e.g.:_

### _Example: TypeScript_

- _`strict: true`; no `any` without a justifying comment._
- _Prefer named exports; default exports only for framework entry points._

## Naming conventions

| Thing | Convention | Example |
|---|---|---|
| _files_ | _kebab-case_ | `user-service.ts` |
| _branches_ | `type/slug` | `feature/user-auth` |
| _commits_ | Conventional Commits | `feat: add session refresh` |
