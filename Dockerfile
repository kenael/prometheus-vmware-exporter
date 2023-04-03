FROM golang:latest as builder
WORKDIR /app
COPY ["go.*", "/app/"] 
RUN go mod download
COPY ["./", "/app/"]
RUN CGO_ENABLED=0 go build -ldflags="-w -s"

FROM scratch
COPY --from=builder /app/prometheus-vmware-exporter /usr/bin/prometheus-vmware-exporter
EXPOSE 9879
ENTRYPOINT ["prometheus-vmware-exporter"]
