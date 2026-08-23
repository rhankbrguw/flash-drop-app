package ports

import (
	"context"
	"flashdrop/server/internal/core/domain"
)

type LocationService interface {
	UpdateLocation(ctx context.Context, loc domain.DriverLocation) error
	TrackDriver(ctx context.Context, driverID string) (<-chan domain.Location, error)
}
