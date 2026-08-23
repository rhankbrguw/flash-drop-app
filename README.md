# FlashDrop

Real-time driver tracking and fleet telemetry. Flutter frontend with Riverpod, OpenStreetMap, and DevicePreview. Go backend with Connect-RPC over HTTP/2, JWT auth, PostgreSQL history storage, and Redis Pub/Sub broadcasting.

---

Clone it, run `make setup` to bootstrap environment and dependencies.

Backend: `make dev` starts PostgreSQL, Redis, and the Go HTTP/2 server on `:8080`.

Auth: `make auth-token` to grab a signed JWT bearer token.

Frontend: `make dev-frontend` to launch the Flutter driver client.

Protobuf: `make proto` to re-generate Go and Dart RPC contracts.

Tests: `make test` for backend, `cd mobile/apps/driver_app && flutter test` for client.

Teardown: `make down` to stop containers, `make clean` to wipe caches.

---

Requires Go 1.22+, Flutter 3.3+, and Docker.
