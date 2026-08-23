package grpc

import (
	"context"
	"errors"
	"os"
	"strings"

	"connectrpc.com/connect"
	"github.com/golang-jwt/jwt/v5"
)

const DriverIDKey contextKey = "driver_id"

func AuthInterceptor() connect.UnaryInterceptorFunc {
	return func(next connect.UnaryFunc) connect.UnaryFunc {
		return func(ctx context.Context, req connect.AnyRequest) (connect.AnyResponse, error) {
			if req.Spec().Procedure == "/location.v1.LocationService/WatchDriver" ||
				req.Spec().Procedure == "/location.v1.LocationService/StreamLocation" ||
				req.Spec().Procedure == "/location.v1.LocationService/GetLocationHistory" {
				driverID, err := validateAuth(req.Header().Get("Authorization"))
				if err != nil {
					return nil, connect.NewError(connect.CodeUnauthenticated, err)
				}
				ctx = context.WithValue(ctx, DriverIDKey, driverID)
			}
			return next(ctx, req)
		}
	}
}

func validateAuth(authHeader string) (string, error) {
	if authHeader == "" {
		return "", errors.New("missing Authorization header")
	}

	parts := strings.Split(authHeader, " ")
	if len(parts) != 2 || strings.ToLower(parts[0]) != "bearer" {
		return "", errors.New("invalid Authorization format")
	}

	tokenString := parts[1]
	secret := os.Getenv("JWT_SECRET")
	if secret == "" {
		secret = "supersecretjwtkeyflashdrop123"
	}

	token, err := jwt.Parse(tokenString, func(t *jwt.Token) (interface{}, error) {
		if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, errors.New("unexpected signing method")
		}
		return []byte(secret), nil
	})

	if err != nil || !token.Valid {
		return "", errors.New("invalid or expired JWT token")
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return "", errors.New("invalid claims format")
	}

	sub, ok := claims["sub"].(string)
	if !ok || sub == "" {
		return "", errors.New("missing sub claim in token")
	}

	return sub, nil
}
