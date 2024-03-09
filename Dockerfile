FROM golang:latest as builder

COPY ./  /data/

WORKDIR /data
RUN go mod tidy && go mod download && go mod vendor && go build -o netatmo-exporter

FROM alpine:latest

COPY --from=builder /data/netatmo-exporter /netatmo-exporter

RUN addgroup -g 1001 -S appgroup && \
    adduser --u 1001 -S appuser appgroup

USER appuser

ENTRYPOINT ["/netatmo-exporter"]