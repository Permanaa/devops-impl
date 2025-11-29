# Stage 1
FROM golang:1.22-alpine AS builder

WORKDIR /build
COPY . .
RUN go mod download
RUN go build -o server .

# Stage 2
FROM gcr.io/distroless/base-debian12

WORKDIR /app
COPY --from=builder /build/server ./server

CMD [ "/app/server" ]
