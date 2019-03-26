FROM golang as builder

ENV GO111MODULE=on

WORKDIR /krisnaahroid

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

EXPOSE 8080
ENTRYPOINT ["/krisnaahroid/go-module"]

FROM scratch
COPY --from=builder /krisnaahroid/go-module /krisnaahroid/
EXPOSE 8080
ENTRYPOINT ["/krisnaahroid/go-module"]
