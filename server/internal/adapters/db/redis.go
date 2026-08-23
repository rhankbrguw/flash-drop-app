package db

import (
	"context"
	"fmt"

	"flashdrop/server/internal/core/ports"
	"github.com/redis/go-redis/v9"
)

type RedisPubSub struct {
	client *redis.Client
}

func NewRedisPubSub(client *redis.Client) ports.PubSub {
	return &RedisPubSub{
		client: client,
	}
}

func (r *RedisPubSub) Publish(ctx context.Context, channel string, message []byte) error {
	if err := r.client.Publish(ctx, channel, message).Err(); err != nil {
		return fmt.Errorf("redisPubSub.Publish: %w", err)
	}
	return nil
}

func (r *RedisPubSub) Subscribe(ctx context.Context, channel string) (<-chan []byte, func() error, error) {
	pubsub := r.client.Subscribe(ctx, channel)
	
	// Wait for confirmation that subscription is created before returning
	_, err := pubsub.Receive(ctx)
	if err != nil {
		return nil, nil, fmt.Errorf("failed to subscribe to channel %s: %w", channel, err)
	}

	msgChan := make(chan []byte)

	// Spin a goroutine to read from the redis channel and send to the go channel
	go func() {
		defer close(msgChan)
		defer pubsub.Close()

		ch := pubsub.Channel()
		for {
			select {
			case <-ctx.Done():
				return
			case msg, ok := <-ch:
				if !ok {
					return
				}
				msgChan <- []byte(msg.Payload)
			}
		}
	}()

	closeFunc := func() error {
		return pubsub.Close()
	}

	return msgChan, closeFunc, nil
}
