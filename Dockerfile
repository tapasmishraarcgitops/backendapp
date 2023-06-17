FROM golang:1.20-alpine AS build
ADD . /src
WORKDIR /src
RUN go get -d -v -t
RUN GOOS=linux GOARCH=amd64 go build -v -o backendapp 

FROM alpine:3.17.3
EXPOSE 8080
CMD ["backendapp"]
ENV VERSION 1.1.4
COPY --from=build /src/backendapp /usr/local/bin/backendapp
RUN chmod +x /usr/local/bin/backendapp
