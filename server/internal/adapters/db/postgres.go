package db

import (
	"context"
	"fmt"
	"log/slog"

	"flashdrop/server/internal/core/domain"
	"flashdrop/server/internal/core/ports"

	"github.com/jackc/pgx/v5/pgxpool"
)

type PostgresLocationRepo struct {
	pool   *pgxpool.Pool
	logger *slog.Logger
}

func NewPostgresLocationRepo(pool *pgxpool.Pool, logger *slog.Logger) *PostgresLocationRepo {
	return &PostgresLocationRepo{
		pool:   pool,
		logger: logger,
	}
}

func (r *PostgresLocationRepo) Migrate(ctx context.Context) error {
	query := `
	CREATE TABLE IF NOT EXISTS driver_locations (
		driver_id TEXT NOT NULL,
		latitude DOUBLE PRECISION NOT NULL,
		longitude DOUBLE PRECISION NOT NULL,
		timestamp BIGINT NOT NULL
	);

	CREATE INDEX IF NOT EXISTS idx_driver_id_timestamp ON driver_locations (driver_id, timestamp DESC);
	`
	_, err := r.pool.Exec(ctx, query)
	if err != nil {
		return fmt.Errorf("failed to migrate driver_locations table: %w", err)
	}
	r.logger.Info("successfully migrated driver_locations table")
	return nil
}

func (r *PostgresLocationRepo) SaveLocation(ctx context.Context, loc domain.DriverLocation) error {
	query := `
	INSERT INTO driver_locations (driver_id, latitude, longitude, timestamp)
	VALUES ($1, $2, $3, $4)
	`
	_, err := r.pool.Exec(ctx, query, loc.DriverID, loc.Location.Latitude, loc.Location.Longitude, loc.Location.Timestamp)
	if err != nil {
		return fmt.Errorf("failed to save location: %w", err)
	}
	r.logger.Info("saved location for driver", slog.String("driver_id", loc.DriverID))
	return nil
}

func (r *PostgresLocationRepo) GetLatestLocation(ctx context.Context, driverID string) (domain.Location, error) {
	query := `
	SELECT latitude, longitude, timestamp
	FROM driver_locations
	WHERE driver_id = $1
	ORDER BY timestamp DESC
	LIMIT 1
	`
	var loc domain.Location
	err := r.pool.QueryRow(ctx, query, driverID).Scan(&loc.Latitude, &loc.Longitude, &loc.Timestamp)
	if err != nil {
		return domain.Location{}, fmt.Errorf("failed to get latest location: %w", err)
	}
	r.logger.Info("got latest location for driver", slog.String("driver_id", driverID))
	return loc, nil
}

func (r *PostgresLocationRepo) GetHistory(ctx context.Context, driverID string, limit int) ([]domain.Location, error) {
	query := `
	SELECT latitude, longitude, timestamp
	FROM driver_locations
	WHERE driver_id = $1
	ORDER BY timestamp DESC
	LIMIT $2
	`
	rows, err := r.pool.Query(ctx, query, driverID, limit)
	if err != nil {
		return nil, fmt.Errorf("failed to query history: %w", err)
	}
	defer rows.Close()

	var history []domain.Location
	for rows.Next() {
		var loc domain.Location
		if err := rows.Scan(&loc.Latitude, &loc.Longitude, &loc.Timestamp); err != nil {
			return nil, fmt.Errorf("failed to scan location history row: %w", err)
		}
		history = append(history, loc)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("rows error in GetHistory: %w", err)
	}

	r.logger.Info("got location history for driver", slog.String("driver_id", driverID), slog.Int("count", len(history)))
	return history, nil
}

// Ensure PostgresLocationRepo implements the interface
var _ ports.LocationRepository = (*PostgresLocationRepo)(nil)
