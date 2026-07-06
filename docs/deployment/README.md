# Deployment Documentation

How this project ships. Maintained by the devops agent; verified during every
release (`.ai/prompts/release.md`).

Must always contain, current and tested:

1. **Environments** — what exists (dev/staging/prod), where, how configured.
2. **Deploy procedure** — exact steps or the pipeline that automates them.
3. **Configuration** — every env var, documented in `.env.example`.
4. **Rollback** — how to get back to the previous version, fast.
5. **Monitoring** — where to look when something is wrong.
