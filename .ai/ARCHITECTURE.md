# Architecture

> Fill this in during project setup. Keep it current — this file is read at the
> start of every AI session and drives every design decision.

## Overview

_One paragraph: what kind of system is this (web app, API, CLI, mobile app, …)
and what architectural style does it follow (monolith, modular monolith,
microservices, serverless, …)? Why?_

## System diagram

```
┌──────────┐     ┌──────────┐     ┌──────────┐
│  Client   │ ──▶ │   API    │ ──▶ │ Database │
└──────────┘     └──────────┘     └──────────┘
```

_Replace with the real topology. Detailed diagrams go in `docs/diagrams/`._

## Components

| Component | Responsibility | Location |
|---|---|---|
| _example: API server_ | _business logic, auth_ | `src/api/` |

## Data flow

_How does a request travel through the system? Where is state kept?_

## Key boundaries and rules

- _Which layers may depend on which? (e.g. "domain logic never imports the web framework")_
- _Where does validation happen?_
- _How do components communicate (REST, events, direct calls)?_

## Cross-cutting concerns

- **Authentication/authorization:** _…_
- **Error handling:** _…_
- **Logging/observability:** _…_
- **Configuration:** _…_

## Changing this document

Architecture changes require an ADR (`templates/adr.md`), recorded in
`DECISIONS.md`, **before** implementation. Update this file when the ADR is accepted.
