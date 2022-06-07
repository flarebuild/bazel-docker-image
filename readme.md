# Bazel Docker Image

This is a simple [Bazelisk](https://github.com/bazelbuild/bazelisk) docker image to quickly build and test stuff with Bazel without hassle of installing it locally.

Bazel docker images from Google are heavily outdated and abandoned: [l.gcr.io/google/bazel](https://console.cloud.google.com/gcr/images/cloud-marketplace-containers/GLOBAL/google/bazel)

Usage: 

```bash
docker run -it --rm -v "$PWD":/app -v /var/run/docker.sock:/var/run/docker.sock -w /app --entrypoint=/bin/bash gcr.io/flare-build-alpha/bazelisk:latest
```

Note: `docker.sock` is mapped to connect to the host Docker (if you need to run built images, etc.)


Drop into your `.zshrc`:

```bash
alias docker-bazel='docker run -it --rm -v "$PWD":/app -v /var/run/docker.sock:/var/run/docker.sock -w /app --entrypoint=/bin/bash gcr.io/flare-build-alpha/bazelisk:latest'
```
