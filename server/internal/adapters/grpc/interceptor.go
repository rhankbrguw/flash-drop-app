package grpc

import (
	"context"

	"connectrpc.com/connect"
	"github.com/google/uuid"
)

type contextKey string

const RequestIDKey contextKey = "request_id"

// RequestIDInterceptor injects a unique Request-ID into the context for tracing.
func RequestIDInterceptor() connect.UnaryInterceptorFunc {
	return func(next connect.UnaryFunc) connect.UnaryFunc {
		return func(ctx context.Context, req connect.AnyRequest) (connect.AnyResponse, error) {
			reqID := req.Header().Get("X-Request-Id")
			if reqID == "" {
				reqID = uuid.NewString()
			}
			ctx = context.WithValue(ctx, RequestIDKey, reqID)
			return next(ctx, req)
		}
	}
}

type StreamInterceptor struct{}

func (s *StreamInterceptor) WrapUnary(next connect.UnaryFunc) connect.UnaryFunc {
	return AuthInterceptor()(RequestIDInterceptor()(next))
}

func (s *StreamInterceptor) WrapStreamingClient(next connect.StreamingClientFunc) connect.StreamingClientFunc {
	return next
}

func (s *StreamInterceptor) WrapStreamingHandler(next connect.StreamingHandlerFunc) connect.StreamingHandlerFunc {
	return func(ctx context.Context, conn connect.StreamingHandlerConn) error {
		// Apply RequestID Injection
		reqID := conn.RequestHeader().Get("X-Request-Id")
		if reqID == "" {
			reqID = uuid.NewString()
		}
		ctx = context.WithValue(ctx, RequestIDKey, reqID)

		// Apply Auth Check
		if conn.Spec().Procedure == "/location.v1.LocationService/WatchDriver" ||
			conn.Spec().Procedure == "/location.v1.LocationService/StreamLocation" {
			driverID, err := validateAuth(conn.RequestHeader().Get("Authorization"))
			if err != nil {
				return connect.NewError(connect.CodeUnauthenticated, err)
			}
			ctx = context.WithValue(ctx, DriverIDKey, driverID)
		}

		return next(ctx, conn)
	}
}
