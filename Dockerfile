FROM golang:1.18

RUN apt-get update -y
RUN apt-get install -y build-essential libssl-dev zlib1g-dev zip unzip

RUN go install github.com/bazelbuild/bazelisk@latest
RUN go install github.com/bazelbuild/buildtools/buildifier@latest

RUN ln -s "$GOPATH/bin/bazelisk" /usr/local/bin/bazel
RUN ln -s "$GOPATH/bin/buildifier" /usr/local/bin/buildifier

CMD ["bazel"]
