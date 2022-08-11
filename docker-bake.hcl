target "bazel" {
  dockerfile = "Dockerfile"
  tags = ["bazel:latest", "gcr.io/flare-build/bazel:latest"]
  platforms = ["linux/amd64", "linux/arm64"]
}
