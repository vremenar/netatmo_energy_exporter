FROM golang:latest as builder

COPY ./  /data/

RUN cd /data && go build -o netatmo-exporter

FROM alpine:latest

RUN addgroup -g 1001 -S appgroup && \
    adduser --u 1001 -S appuser appgroup

USER appuser
COPY --from=0 /data/netatmo-exporter /app/netatmo-exporter

ENTRYPOINT ["/app/netatmo-exporter"]
