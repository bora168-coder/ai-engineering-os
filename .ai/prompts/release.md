# Prompt: Release

Use when preparing and shipping a release.

---

Release: **[version, e.g. v1.2.0]**

## Pre-flight

1. Verify version bump follows SemVer given the changes since last release
   (breaking → major, feature → minor, fix → patch).
2. All planned tasks for this release are in `tasks/completed.md`; anything
   unfinished is explicitly descoped (update `tasks/sprint.md` and `ROADMAP.md`).
3. Full test suite green. Lint clean. CI green on the release branch/main.
4. QA regression pass (`agents/qa.md`): exercise the critical user journeys
   end-to-end, plus every feature added this release.
5. Security pass for releases containing auth/input/permission changes
   (`agents/security.md`).

## Ship

6. Finalize `CHANGELOG.md`: move `[Unreleased]` items under the new version
   with today's date; entries describe user-visible impact, not commit messages.
7. Update version identifiers (package manifest, docs) as the stack requires.
8. Tag: `git tag -a vX.Y.Z -m "vX.Y.Z"` and push the tag. Deploy per
   `docs/deployment/`.

## Post-flight

9. Verify the deployed release actually works (smoke test in the live environment).
10. Record: `ROADMAP.md` milestone progress; `memory/technical.md` for anything
    learned; rollback notes confirmed current in `docs/deployment/`.

If anything fails pre-flight, the release stops. No "ship it anyway".
