# AGENTS.md

> Read this file before every task. The global `engineering-standards` skill applies
> to all code. This file provides project-specific context that overrides or extends it.

---

## Project

```
name    : FlashDrop
stack   : Go 1.22+ (Connect-RPC/h2c) + Flutter / Dart 3+ (Riverpod) + Protobuf
arch    : Hexagonal / Ports & Adapters (Backend) + Feature-First Riverpod (Mobile)
db      : PostgreSQL 15 (History) + Redis 7 (Pub/Sub & Low Latency Streaming)
```

## Active Stack Rules

```
stacks: [go, flutter, dart, protobuf]
```

## Folder Structure

```
flash-drop/
├── proto/v1/                   # Protobuf definitions (location.proto)
├── server/                     # Go Backend
│   ├── cmd/
│   │   ├── api/                # Main entrypoint (h2c HTTP/2 server)
│   │   └── auth-token/         # JWT generation tool
│   ├── internal/
│   │   ├── core/
│   │   │   ├── domain/         # Core domain models & business entities
│   │   │   └── ports/          # Interfaces (Repositories & Services)
│   │   └── adapters/
│   │       ├── db/             # Postgres repository & Redis pub/sub
│   │       └── grpc/           # Connect-RPC handlers & Auth interceptors
└── mobile/                     # Flutter Mobile Workspace
    ├── packages/
    │   └── api_client/         # Generated protobuf stubs & gRPC client
    └── apps/
        └── driver_app/         # Driver mobile application
            └── lib/
                ├── core/       # Theme, constants, tokens
                └── features/   # Feature modules (auth, tracking)
                    ├── application/   # Riverpod state notifiers & providers
                    └── presentation/  # UI Views & Widgets
```

## Error Code Registry

| Code / Connect Error | HTTP Status | Meaning                                 |
| -------------------- | ----------- | --------------------------------------- |
| `InvalidArgument`    | 400         | Input validation or invalid coordinates |
| `Unauthenticated`    | 401         | Missing, malformed, or expired JWT      |
| `PermissionDenied`   | 403         | Insufficient driver or fleet role       |
| `NotFound`           | 404         | Driver or location history not found    |
| `Internal`           | 500         | Unexpected server or database failure   |
| `Unavailable`        | 503         | PostgreSQL or Redis connection down     |

## Agent Constraints

Must:

- Propose approach before touching more than one file.
- Follow strict layered architecture: Handlers/UI → Services/Application → Repositories/Adapters.
- Pass `context.Context` as the first parameter for all Go I/O functions.
- Always wrap Go errors with context: `fmt.Errorf("scope.operation: %w", err)`.
- Enforce full Dart null safety; never use `!` bang operator without proof.
- Centralize all colors, typography, strings, and config in constants/tokens.
- Re-run `make proto` when updating `.proto` contracts to regenerate Go & Dart stubs.
- Ask before adding new third-party libraries or dependencies.

Must not:

- Write business logic in `main.go`, RPC handlers, or Flutter UI widgets.
- Write raw inline color values, magic numbers, or hardcoded strings.
- Leave any TODOs, placeholder code, or debug logs in final output.
- Swallow errors silently or use `_ =` on error checks.
- Exceed 150 lines per file or 30 lines per function.
- Create or rename directories without explicit user confirmation.
