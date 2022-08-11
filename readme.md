# Bazel Docker Image

This is a simple [Bazelisk](https://github.com/bazelbuild/bazelisk) docker image to quickly build and test stuff with Bazel without hassle of installing it locally.

Bazel docker images from Google are heavily outdated and abandoned: [l.gcr.io/google/bazel](https://console.cloud.google.com/gcr/images/cloud-marketplace-containers/GLOBAL/google/bazel). This is a drop-in replacement.

## Usage 

```bash
# cd /some/bazel/workspace 
docker run --rm -v "$PWD":/app gcr.io/flare-build/bazel:latest build //...
```

ℹ️ Tip: To use docker from the host (if you need to run built images, etc.), provide mapping for `docker.sock`:

```bash
# cd /some/bazel/workspace 

docker run -it --rm -v "$PWD":/app \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --entrypoint=/bin/bash gcr.io/flare-build/bazel:latest

# bazel build //...
```

ℹ️ Tip: Additional mappings to preserve disk cache between runs:

```bash
docker run -it --rm -v "$PWD":/app \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$HOME/.cache/bazel-docker-bazelisk":/root/.cache/bazelisk \
  -v "$HOME/.cache/bazel-docker-cache":/root/.cache/bazel \
  --entrypoint=/bin/bash gcr.io/flare-build/bazel:latest
```

Wrap all this in alias (put into your `.zshrc` / `.bashrc`):

```bash
alias docker-bazel='docker run -it --rm -v "$PWD":/app -v /var/run/docker.sock:/var/run/docker.sock -v "$HOME/.cache/bazel-docker-bazelisk":/root/.cache/bazelisk -v "$HOME/.cache/bazel-docker-cache":/root/.cache/bazel gcr.io/flare-build/bazel:latest'
alias docker-bazel-bash='docker run -it --rm -v "$PWD":/app -v /var/run/docker.sock:/var/run/docker.sock -v "$HOME/.cache/bazel-docker-bazelisk":/root/.cache/bazelisk -v "$HOME/.cache/bazel-docker-cache":/root/.cache/bazel --entrypoint=/bin/bash gcr.io/flare-build/bazel:latest'
```

Use aliased:

```bash
# cd /some/bazel/workspace
docker-bazel build //...
```

Or, to gain shell access:

```bash
# cd /some/bazel/workspace
docker-bazel-bash
root@31678cbd565a:/app# bazel build //...
```
