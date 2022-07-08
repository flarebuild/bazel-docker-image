FROM ubuntu:jammy

RUN apt update -y
RUN apt install -y apt-utils build-essential ca-certificates libssl-dev zlib1g-dev zip unzip
RUN apt install -y git golang python-is-python3

RUN go install github.com/bazelbuild/bazelisk@latest
RUN go install github.com/bazelbuild/buildtools/buildifier@latest

RUN ln -s "$HOME/go/bin/bazelisk" /usr/local/bin/bazel
RUN ln -s "$HOME/go/bin/buildifier" /usr/local/bin/buildifier

RUN git clone https://github.com/bazelbuild/bazel-watcher.git \
    && cd bazel-watcher \
    && git checkout v0.16.2 \
    && bazel build //ibazel \
    && cp bazel-bin/ibazel/ibazel_/ibazel /usr/local/bin/ibazel \
    && cd .. && rm -rf bazel-watcher

CMD ["bazel"]
