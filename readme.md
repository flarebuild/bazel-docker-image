# Bazel Docker Image

This is a simple [Bazelisk](https://github.com/bazelbuild/bazelisk) docker image to quickly build and test stuff with Bazel without hassle of installing it locally.

Bazel docker images from Google are heavily outdated and abandoned: [l.gcr.io/google/bazel](https://console.cloud.google.com/gcr/images/cloud-marketplace-containers/GLOBAL/google/bazel). This is a drop-in replacement.

Usage: 

```bash
# cd /some/bazel/workspace 

docker run -it --rm -v "$PWD":/app \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$HOME/.cache/bazel-docker-bazelisk":/root/.cache/bazelisk \
  -v "$HOME/.cache/bazel-docker-cache":/root/.cache/bazel \
  -w /app --entrypoint=/bin/bash gcr.io/flare-build/bazel:latest-ubuntu

# bazel build //...
```

Note: `docker.sock` is mapped to connect to the host Docker (if you need to run built images, etc.)


Put into your `.zshrc` / `.bashrc`:

```bash
alias docker-bazel='docker run -it --rm -v "$PWD":/app -v /var/run/docker.sock:/var/run/docker.sock -v "$HOME/.cache/bazel-docker-bazelisk":/root/.cache/bazelisk -v "$HOME/.cache/bazel-docker-cache":/root/.cache/bazel -w /app --entrypoint=/bin/bash gcr.io/flare-build/bazel:latest'
```

Use:

```bash
# cd /some/bazel/workspace 

docker-bazel

root@31678cbd565a:/app# bazel build //...
```
