.PHONY: help setup proto dev dev-backend dev-frontend dev-docker infra-up infra-down db-shell auth-token test down clean

export PATH := $(HOME)/.local/bin:$(shell go env GOPATH 2>/dev/null)/bin:$(HOME)/.pub-cache/bin:$(PATH)

help: ## Show this help message
	@echo "FlashDrop Engineering Commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

setup: ## Bootstrap project environment (.env, Go modules, Flutter deps)
	@echo "🔧 Running pre-flight setup..."
	@if [ ! -f server/.env ]; then cp server/.env.example server/.env && echo "Created server/.env from template"; fi
	@cd server && go mod tidy
	@cd mobile/packages/api_client && flutter pub get
	@cd mobile/apps/driver_app && flutter pub get
	@echo "✅ Environment setup complete."

infra-up: ## Start PostgreSQL & Redis with healthchecks
	@echo "🚀 Starting database and cache services..."
	@docker compose up -d postgres redis

infra-down: ## Stop PostgreSQL & Redis containers
	@echo "🛑 Stopping database and cache services..."
	@docker compose stop postgres redis

dev: infra-up ## Start recommended hybrid dev environment (Infra + Go Backend)
	@echo "🚀 Starting Go backend (Air hot-reload or go run)..."
	@if command -v air >/dev/null 2>&1; then cd server && air; else cd server && go run cmd/api/main.go; fi

dev-backend: ## Run Go backend directly on host
	@cd server && (air 2>/dev/null || go run cmd/api/main.go)

dev-frontend: ## Launch Flutter Driver application
	@echo "📱 Starting Flutter Driver App..."
	@cd mobile/apps/driver_app && flutter run

dev-docker: ## Start full-stack services in Docker containers
	@echo "🐳 Starting all services via Docker..."
	@docker compose up -d

auth-token: ## Generate a test driver JWT token for login
	@cd server && go run cmd/auth-token/main.go

proto: ## Re-generate Protobuf & Riverpod stubs for Go and Dart
	@echo "⚡ Generating protobuf & connect-rpc stubs..."
	@mkdir -p server/internal/adapters/grpc/gen mobile/packages/api_client/lib/src/gen
	@protoc -I proto/v1 \
		--go_out=server/internal/adapters/grpc/gen --go_opt=paths=source_relative \
		--connect-go_out=server/internal/adapters/grpc/gen --connect-go_opt=paths=source_relative \
		--dart_out=grpc:mobile/packages/api_client/lib/src/gen \
		proto/v1/location.proto
	@cd mobile/packages/api_client && dart run build_runner build -d
	@cd mobile/apps/driver_app && dart run build_runner build -d
	@echo "✅ Protobuf and Riverpod generation complete."

test: ## Run backend unit & integration tests
	@cd server && go test -v ./...

db-shell: ## Open interactive PostgreSQL terminal
	@docker exec -it flash-drop-postgres-1 psql -U postgres -d flashdrop

down: ## Stop and remove all project containers
	@docker compose down

clean: down ## Clean temporary build artifacts and caches
	@rm -rf server/tmp mobile/packages/api_client/.dart_tool mobile/apps/driver_app/.dart_tool
	@echo "🧹 Cleaned up temporary files."

