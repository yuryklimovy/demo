FROM golang as builder
WORKDIR /src
COPY src .
RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -o app
RUN chmod +x /src/app


FROM scratch
ADD ./html /html
COPY --from=builder /src/app .
ENTRYPOINT ["/app"]
EXPOSE 8080