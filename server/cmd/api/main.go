package main

import (
	"context"
	"log/slog"
	"net/http"
	"os"

	"flashdrop/server/internal/adapters/db"
	adaptergrpc "flashdrop/server/internal/adapters/grpc"
	"flashdrop/server/internal/adapters/grpc/gen/locationv1connect"

	"connectrpc.com/connect"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/joho/godotenv"
	"github.com/redis/go-redis/v9"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

func main() {
	logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))
	slog.SetDefault(logger)

	slog.Info("Starting FlashDrop API server")

	if err := godotenv.Load(".env", "server/.env"); err != nil {
		slog.Warn("No .env file found, relying on environment variables", slog.String("error", err.Error()))
	}

	dbURL := os.Getenv("DB_URL")
	if dbURL == "" {
		slog.Error("DB_URL environment variable is not set")
		os.Exit(1)
	}

	ctx := context.Background()

	pool, err := pgxpool.New(ctx, dbURL)
	if err != nil {
		slog.Error("Failed to connect to database", slog.String("error", err.Error()))
		os.Exit(1)
	}
	defer pool.Close()

	if err := pool.Ping(ctx); err != nil {
		slog.Error("Failed to ping database", slog.String("error", err.Error()))
		os.Exit(1)
	}

	slog.Info("Connected to PostgreSQL successfully")

	repo := db.NewPostgresLocationRepo(pool, logger)
	if err := repo.Migrate(ctx); err != nil {
		slog.Error("Database migration failed", slog.String("error", err.Error()))
		os.Exit(1)
	}

	redisURL := os.Getenv("REDIS_URL")
	if redisURL == "" {
		slog.Error("REDIS_URL environment variable is not set")
		os.Exit(1)
	}

	redisOpt, err := redis.ParseURL(redisURL)
	if err != nil {
		slog.Error("Failed to parse redis URL", slog.String("error", err.Error()))
		os.Exit(1)
	}

	redisClient := redis.NewClient(redisOpt)
	if err := redisClient.Ping(ctx).Err(); err != nil {
		slog.Error("Failed to ping Redis", slog.String("error", err.Error()))
		os.Exit(1)
	}
	slog.Info("Connected to Redis successfully")

	pubsub := db.NewRedisPubSub(redisClient)

	grpcHandler := adaptergrpc.NewLocationHandler(repo, pubsub, logger)

	mux := http.NewServeMux()
	
	interceptors := connect.WithInterceptors(&adaptergrpc.StreamInterceptor{})
	path, handler := locationv1connect.NewLocationServiceHandler(grpcHandler, interceptors)
	mux.Handle(path, handler)

	mux.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("OK"))
	})

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	addr := ":" + port
	slog.Info("Starting HTTP/2 server", slog.String("addr", addr))
	srv := &http.Server{
		Addr:    addr,
		Handler: h2c.NewHandler(mux, &http2.Server{}),
	}

	if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		slog.Error("Server failed", slog.String("error", err.Error()))
		os.Exit(1)
	}
}
