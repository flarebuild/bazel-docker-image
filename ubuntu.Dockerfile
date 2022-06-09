FROM ubuntu:jammy

RUN apt-get update -y
RUN apt-get install -y apt-utils build-essential ca-certificates libssl-dev zlib1g-dev zip unzip
RUN apt-get install -y golang

RUN go install github.com/bazelbuild/bazelisk@latest
RUN go install github.com/bazelbuild/buildtools/buildifier@latest

RUN ln -s "/root/go/bin/bazelisk" /usr/local/bin/bazel
RUN ln -s "/root/go/bin/buildifier" /usr/local/bin/buildifier

CMD ["bazel"]
