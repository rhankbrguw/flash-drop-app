FROM golang:1.24-alpine AS builder

WORKDIR /app

COPY go.mod ./
# COPY go.sum ./ # (uncomment when go.sum is generated)

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /api ./cmd/api

FROM gcr.io/distroless/static-debian12

COPY --from=builder /api /api

EXPOSE 8080

ENTRYPOINT ["/api"]
