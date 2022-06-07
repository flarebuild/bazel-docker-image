FROM golang:1.18

RUN go install github.com/bazelbuild/bazelisk@latest
RUN ln -s "$HOME/go/bin/bazelisk" /usr/local/bin/bazel

RUN go install github.com/bazelbuild/buildtools/buildifier@latest
RUN ln -s "$HOME/go/bin/buildifier" /usr/local/bin/buildifier

CMD ["bazel"]
