package grpc

import (
	"context"
	"errors"
	"log/slog"

	"connectrpc.com/connect"
	locationv1 "flashdrop/server/internal/adapters/grpc/gen"
)

const (
	defaultHistoryLimit = 100
	maxHistoryLimit     = 1000
)

// GetLocationHistory retrieves the breadcrumb trail for a specific driver.
func (h *LocationHandler) GetLocationHistory(
	ctx context.Context,
	req *connect.Request[locationv1.GetLocationHistoryRequest],
) (*connect.Response[locationv1.GetLocationHistoryResponse], error) {
	reqID, _ := ctx.Value(RequestIDKey).(string)
	driverID := req.Msg.DriverId
	limit := req.Msg.Limit

	if limit <= 0 || limit > maxHistoryLimit {
		limit = defaultHistoryLimit
	}

	h.logger.Info("Fetching location history", slog.String("driver_id", driverID), slog.String("request_id", reqID))

	if err := h.validateHistoryAccess(ctx, driverID, reqID); err != nil {
		return nil, err
	}

	history, err := h.repo.GetHistory(ctx, driverID, int(limit))
	if err != nil {
		h.logger.Error("Failed to fetch location history", slog.String("error", err.Error()), slog.String("request_id", reqID))
		return nil, connect.NewError(connect.CodeInternal, err)
	}

	var protoLocations []*locationv1.Location
	for _, loc := range history {
		protoLocations = append(protoLocations, &locationv1.Location{
			Latitude:  loc.Latitude,
			Longitude: loc.Longitude,
			Timestamp: loc.Timestamp,
		})
	}

	return connect.NewResponse(&locationv1.GetLocationHistoryResponse{
		Locations: protoLocations,
	}), nil
}

func (h *LocationHandler) validateHistoryAccess(ctx context.Context, driverID, reqID string) error {
	authDriverID, _ := ctx.Value(DriverIDKey).(string)
	if authDriverID != "" && authDriverID != driverID {
		h.logger.Warn("Driver history fetch mismatch",
			slog.String("jwt_sub", authDriverID),
			slog.String("req_driver_id", driverID),
			slog.String("request_id", reqID),
		)
		return connect.NewError(connect.CodePermissionDenied, errors.New("cannot fetch history for another driver"))
	}
	return nil
}
