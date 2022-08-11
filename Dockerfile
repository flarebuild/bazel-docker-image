FROM --platform=$BUILDPLATFORM debian:bullseye-slim AS build

RUN apt update -y
RUN apt install -y --no-install-recommends \
    apt-utils build-essential ca-certificates \
    curl git zip unzip \
    python-is-python3

WORKDIR /tmp
ARG TARGETOS TARGETARCH

RUN curl --location --max-redirs 5 \
    https://github.com/bazelbuild/bazelisk/releases/download/v1.12.0/bazelisk-linux-$TARGETARCH \
    --output /usr/local/bin/bazel \
    && chmod +x /usr/local/bin/bazel

WORKDIR /src
RUN git clone https://github.com/bazelbuild/bazel-watcher.git \
    && cd bazel-watcher \
    && git checkout v0.18.0 \
    && bazel build //ibazel --platforms=@io_bazel_rules_go//go/toolchain:linux_$TARGETARCH

ARG BUILDTOOLS_VERSION="5.1.0"

RUN curl --location --max-redirs 5 \
    https://github.com/bazelbuild/buildtools/releases/download/$BUILDTOOLS_VERSION/buildifier-linux-$TARGETARCH \
    --output /usr/local/bin/buildifier \
    && chmod +x /usr/local/bin/buildifier

RUN curl --location --max-redirs 5 \
    https://github.com/bazelbuild/buildtools/releases/download/$BUILDTOOLS_VERSION/buildozer-linux-$TARGETARCH \
    --output /usr/local/bin/buildozer \
    && chmod +x /usr/local/bin/buildozer

RUN curl --location --max-redirs 5 \
    https://github.com/bazelbuild/buildtools/releases/download/$BUILDTOOLS_VERSION/unused_deps-linux-$TARGETARCH \
    --output /usr/local/bin/unused_deps \
    && chmod +x /usr/local/bin/unused_deps


FROM debian:bullseye-slim

RUN apt update -y
RUN apt install -y --no-install-recommends \
    apt-utils build-essential ca-certificates gnupg lsb-release \
    curl git zip unzip

COPY --from=build /usr/local/bin/bazel /usr/local/bin/
COPY --from=build /src/bazel-watcher/bazel-bin/ibazel/ibazel_/ibazel /usr/local/bin/
COPY --from=build /usr/local/bin/buildifier /usr/local/bin/buildozer /usr/local/bin/unused_deps /usr/local/bin/

# Docker CLI
# Use with mapping from the host: `docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock ...`
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
        $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt update -y \
    && apt install -y --no-install-recommends docker-ce-cli

WORKDIR /app
ENTRYPOINT ["bazel"]
