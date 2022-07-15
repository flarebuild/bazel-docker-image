FROM ubuntu:jammy

RUN apt update -y
RUN apt install -y --no-install-recommends \
    apt-utils build-essential ca-certificates gnupg lsb-release \
    libssl-dev zlib1g-dev \
    curl git zip unzip \
    python-is-python3

RUN curl --location --max-redirs 5 \
    https://github.com/bazelbuild/buildtools/releases/download/5.1.0/buildifier-linux-amd64 \
    --output /usr/local/bin/buildifier \
    && chmod +x /usr/local/bin/buildifier

RUN curl --location --max-redirs 5 \
    https://github.com/bazelbuild/buildtools/releases/download/5.1.0/buildozer-linux-amd64 \
    --output /usr/local/bin/buildozer \
    && chmod +x /usr/local/bin/buildozer

RUN curl --location --max-redirs 5 \
    https://github.com/bazelbuild/buildtools/releases/download/5.1.0/unused_deps-linux-amd64 \
    --output /usr/local/bin/unused_deps \
    && chmod +x /usr/local/bin/unused_deps

RUN curl --location --max-redirs 5 \
    https://github.com/bazelbuild/bazelisk/releases/download/v1.12.0/bazelisk-linux-amd64 \
    --output /usr/local/bin/bazel \
    && chmod +x /usr/local/bin/bazel

RUN curl --location --max-redirs 5 \
    https://github.com/bazelbuild/bazel-watcher/releases/download/v0.16.2/ibazel_linux_amd64 \
    --output /usr/local/bin/ibazel \
    && chmod +x /usr/local/bin/ibazel

# Docker CLI
# Use with mapping from the host: `docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock ...`
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt update -y \
    && apt install -y --no-install-recommends docker-ce-cli

CMD ["bazel"]
