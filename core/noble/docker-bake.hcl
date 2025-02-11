# GENERATED FILE, DO NOT MODIFY!
# To update this file please edit the relevant template and run the generation
# task `rake generate:core`

# https://docs.docker.com/engine/reference/commandline/buildx_bake/#file-definition


variable "PWD" {default="" }

group "default" {
    targets = ["core"]
}

# NOTE: the context is required for now due to https://github.com/docker/buildx/issues/1028
target "core" {
  tags = ["127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/core:latest", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/core:noble", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/core:noble-slim"]
  context = "${PWD}/core/noble"
  platforms = ["linux/amd64", "linux/arm64"]
  cache-from = [
    "type=gha,scope=core/noble",
    "type=registry,ref=ghcr.io/get-bridge/core:noble-cache"
  ]
  cache-to = [
    # disabled while GitHub Actions cache is cranky
    # "type=gha,scope=core/noble,mode=max"
  ]
}
