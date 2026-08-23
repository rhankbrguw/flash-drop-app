package grpc

import (
	"context"
	"log/slog"

	"connectrpc.com/connect"
	locationv1 "flashdrop/server/internal/adapters/grpc/gen"
	"google.golang.org/protobuf/proto"
)

// WatchDriver streams a driver's location in real-time.
func (h *LocationHandler) WatchDriver(
	ctx context.Context,
	req *connect.Request[locationv1.WatchDriverRequest],
	stream *connect.ServerStream[locationv1.WatchDriverResponse],
) error {
	driverID := req.Msg.DriverId
	reqID, _ := ctx.Value(RequestIDKey).(string)
	h.logger.Info("Client subscribed to driver", slog.String("driver_id", driverID), slog.String("request_id", reqID))

	channel := "driver:location:" + driverID
	ch, cancel, err := h.pubsub.Subscribe(ctx, channel)
	if err != nil {
		h.logger.Error("Failed to subscribe to redis", slog.String("error", err.Error()), slog.String("request_id", reqID))
		return connect.NewError(connect.CodeInternal, err)
	}
	defer cancel()

	for {
		select {
		case <-ctx.Done():
			h.logger.Info("Client disconnected from WatchDriver", slog.String("driver_id", driverID), slog.String("request_id", reqID))
			return nil
		case msg, ok := <-ch:
			if !ok {
				return nil
			}
			if err := h.sendWatchResponse(stream, msg, reqID); err != nil {
				return err
			}
		}
	}
}

func (h *LocationHandler) sendWatchResponse(
	stream *connect.ServerStream[locationv1.WatchDriverResponse],
	msg []byte,
	reqID string,
) error {
	var loc locationv1.Location
	if err := proto.Unmarshal(msg, &loc); err != nil {
		h.logger.Error("Failed to unmarshal location from redis", slog.String("error", err.Error()), slog.String("request_id", reqID))
		return nil
	}

	res := &locationv1.WatchDriverResponse{Location: &loc}
	if err := stream.Send(res); err != nil {
		h.logger.Error("Failed to send driver location", slog.String("error", err.Error()), slog.String("request_id", reqID))
		return err
	}
	return nil
}
