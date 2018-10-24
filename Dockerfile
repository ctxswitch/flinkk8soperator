# Uses Docker multistage build https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM lyft/go:1971674ff5de7e75c43fb9c2d993cfd4bd86b2f8 as builder
COPY . ${GOPATH}/src/github.com/lyft/flinkk8soperator
WORKDIR ${GOPATH}/src/github.com/lyft/flinkk8soperator
RUN dep ensure && \
    rm -f flinkk8soperator.bin && \
    go build -o flinkk8soperator.bin ./cmd/flinkk8soperator/main.go && \
    mv ./flinkk8soperator.bin /bin/flinkk8soperator

ENTRYPOINT ["/bin/flinkk8soperator"]
