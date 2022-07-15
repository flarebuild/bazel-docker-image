FROM ubuntu:jammy

RUN apt update -y
RUN apt install -y apt-utils build-essential ca-certificates libssl-dev zlib1g-dev zip unzip
RUN apt install -y git golang python-is-python3

RUN go install github.com/bazelbuild/bazelisk@latest
RUN go install github.com/bazelbuild/buildtools/buildifier@latest

RUN ln -s "$HOME/go/bin/bazelisk" /usr/local/bin/bazel
RUN ln -s "$HOME/go/bin/buildifier" /usr/local/bin/buildifier

RUN curl --location --max-redirs 5 --output /usr/local/bin/ibazel \
    https://github.com/bazelbuild/bazel-watcher/releases/download/v0.16.2/ibazel_linux_amd64 \
    && chmod +x /usr/local/bin/ibazel

CMD ["bazel"]
