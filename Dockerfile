FROM golang:latest as builder

COPY ./  /data/

WORKDIR /data
RUN go mod tidy && go mod download && go mod vendor && go build -o netatmo-exporter

FROM alpine:latest

RUN addgroup -g 1001 -S appgroup && \
    adduser --u 1001 -S appuser appgroup

USER appuser
COPY --from=builder /data/netatmo-exporter /app/netatmo-exporter

ENTRYPOINT ["/app/netatmo-exporter"]
