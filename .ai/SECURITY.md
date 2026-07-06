# Security

Baseline requirements for every project built on this OS. Stack-specific rules
are added during setup.

## Absolute rules

1. **No secrets in the repo.** Credentials, API keys, tokens live in environment
   variables or a secret manager. Commit `.env.example` with dummy values only.
   If a secret ever lands in git history, rotate it immediately — deleting the
   commit is not enough.
2. **Validate all external input at the boundary** — request bodies, query
   params, headers, file uploads, webhook payloads. Whitelist, don't blacklist.
3. **Parameterized queries only.** String-built SQL is forbidden.
4. **Encode output** per context (HTML, URL, SQL, shell) — this is XSS/injection defense.
5. **Least privilege everywhere:** DB users, API tokens, IAM roles, file permissions.

## Authentication & authorization

- Passwords: strong adaptive hashing (argon2/bcrypt), never reversible encryption.
- Sessions/tokens: short-lived, revocable, `HttpOnly`+`Secure` cookies where applicable.
- Authorization checks server-side on **every** request — never trust the client.

## Dependencies

- Enable Dependabot / audit tooling; treat known-vulnerable dependencies as bugs.
- Review what a new dependency pulls in before adding it (`RULES.md` rule 10).

## Data

- Classify data (public / internal / sensitive / regulated) in `memory/business.md`.
- Encrypt sensitive data in transit (TLS) and at rest.
- Log events, not payloads: no passwords, tokens, or PII in logs.

## Process

- Security-relevant changes (auth, crypto, input handling, permissions) get an
  extra review pass using `agents/security.md`.
- Track discovered vulnerabilities in `memory/known-issues.md` with severity,
  and fix critical ones before any feature work.
