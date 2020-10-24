FROM golang:1.14.4-alpine3.12 AS stage0

RUN apk --update add git bash && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apk/*

ARG etcd_version=v3.4.0
RUN git clone https://github.com/etcd-io/etcd.git /tmp/etcd --branch $etcd_version
WORKDIR /tmp/etcd
ENV GO_BUILD_FLAGS "-mod=readonly" 
RUN ./build && cp bin/etcd bin/etcdctl /go/bin
WORKDIR /tmp
RUN rm -rf /tmp/etcd

FROM alpine:3.12 AS final
COPY --from=stage0 /go/bin/etcd /go/bin/etcdctl /bin/

RUN rm -rf /var/lib/apt/lists/* /var/cache/apk/*

