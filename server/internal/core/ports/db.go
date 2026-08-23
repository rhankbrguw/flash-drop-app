package ports

import (
	"context"
	"flashdrop/server/internal/core/domain"
)

type LocationRepository interface {
	SaveLocation(ctx context.Context, loc domain.DriverLocation) error
	GetLatestLocation(ctx context.Context, driverID string) (domain.Location, error)
	GetHistory(ctx context.Context, driverID string, limit int) ([]domain.Location, error)
}

type PubSub interface {
	Publish(ctx context.Context, channel string, message []byte) error
	Subscribe(ctx context.Context, channel string) (<-chan []byte, func() error, error)
}

type GeofenceService interface {
	CheckGeofenceCrossings(ctx context.Context, loc domain.DriverLocation) error
}
