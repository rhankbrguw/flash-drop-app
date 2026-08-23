package grpc

import (
	"context"
	"errors"
	"io"
	"log/slog"

	"connectrpc.com/connect"
	"flashdrop/server/internal/core/domain"
	"flashdrop/server/internal/core/ports"
	"google.golang.org/protobuf/proto"

	locationv1 "flashdrop/server/internal/adapters/grpc/gen"
	"flashdrop/server/internal/adapters/grpc/gen/locationv1connect"
)

const geofenceRadiusMeters = 200.0

type LocationHandler struct {
	repo   ports.LocationRepository
	pubsub ports.PubSub
	logger *slog.Logger
	locationv1connect.UnimplementedLocationServiceHandler
}

func NewLocationHandler(repo ports.LocationRepository, pubsub ports.PubSub, logger *slog.Logger) *LocationHandler {
	return &LocationHandler{
		repo:   repo,
		pubsub: pubsub,
		logger: logger,
	}
}

func (h *LocationHandler) StreamLocation(
	ctx context.Context,
	stream *connect.ClientStream[locationv1.StreamLocationRequest],
) (*connect.Response[locationv1.StreamLocationResponse], error) {
	reqID, _ := ctx.Value(RequestIDKey).(string)
	h.logger.Info("Started StreamLocation connection", slog.String("request_id", reqID))

	for stream.Receive() {
		req := stream.Msg()
		if err := h.validateDriverToken(ctx, req.DriverId, reqID); err != nil {
			return nil, err
		}

		if req.Location != nil {
			h.processDriverLocation(ctx, req.DriverId, req.Location, reqID)
		}
	}

	if err := stream.Err(); err != nil && !errors.Is(err, io.EOF) {
		h.logger.Error("Stream error", slog.String("error", err.Error()), slog.String("request_id", reqID))
		return nil, connect.NewError(connect.CodeUnknown, err)
	}

	return connect.NewResponse(&locationv1.StreamLocationResponse{Success: true}), nil
}

func (h *LocationHandler) validateDriverToken(ctx context.Context, reqDriverID, reqID string) error {
	authDriverID, _ := ctx.Value(DriverIDKey).(string)
	if authDriverID != "" && authDriverID != reqDriverID {
		h.logger.Warn("Driver ID mismatch in StreamLocation",
			slog.String("jwt_sub", authDriverID),
			slog.String("req_driver_id", reqDriverID),
			slog.String("request_id", reqID),
		)
		return connect.NewError(connect.CodePermissionDenied, errors.New("driver_id does not match token"))
	}
	return nil
}

func (h *LocationHandler) processDriverLocation(
	ctx context.Context,
	driverID string,
	pbLoc *locationv1.Location,
	reqID string,
) {
	loc := domain.DriverLocation{
		DriverID: driverID,
		Location: domain.Location{
			Latitude:  pbLoc.Latitude,
			Longitude: pbLoc.Longitude,
			Timestamp: pbLoc.Timestamp,
		},
	}

	if err := h.repo.SaveLocation(ctx, loc); err != nil {
		h.logger.Error("Failed to save location", slog.String("error", err.Error()), slog.String("request_id", reqID))
		return
	}

	h.checkGeofenceAlert(driverID, loc.Location, reqID)
	h.publishLocationUpdate(ctx, driverID, pbLoc, reqID)
}

func (h *LocationHandler) checkGeofenceAlert(driverID string, loc domain.Location, reqID string) {
	destination := domain.Location{Latitude: 37.7755, Longitude: -122.4180}
	if loc.IsInsideRadius(destination, geofenceRadiusMeters) {
		h.logger.Info("GEOFENCE_ARRIVED: Driver is approaching destination!",
			slog.String("driver_id", driverID),
			slog.String("request_id", reqID),
		)
	}
}

func (h *LocationHandler) publishLocationUpdate(
	ctx context.Context,
	driverID string,
	loc *locationv1.Location,
	reqID string,
) {
	data, err := proto.Marshal(loc)
	if err != nil {
		h.logger.Error("Failed to marshal location for pubsub", slog.String("error", err.Error()), slog.String("request_id", reqID))
		return
	}

	channel := "driver:location:" + driverID
	if err := h.pubsub.Publish(ctx, channel, data); err != nil {
		h.logger.Error("Failed to publish location", slog.String("error", err.Error()), slog.String("request_id", reqID))
	}
}
