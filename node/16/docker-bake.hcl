# GENERATED FILE, DO NOT MODIFY!
# To update this file please edit the relevant template and run the generation
# task `rake generate:node`

# https://docs.docker.com/engine/reference/commandline/buildx_bake/#file-definition

variable "PWD" {default="" }

group "default" {
  targets = ["node"]
}

# NOTE: the context is required for now due to https://github.com/docker/buildx/issues/1028
target "node" {
  tags = ["127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:16", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:16-slim", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:16-slim-jammy", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:16.20.0-slim", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:16.20.0-slim-jammy"]
  context = "${PWD}/node/16"
  platforms = ["linux/amd64", "linux/arm64"]
  cache-from = [
    "type=gha,scope=node/16",
    "type=registry,ref=ghcr.io/get-bridge/node:16-cache"
  ]
  cache-to = [
    # disabled while GitHub Actions cache is cranky
    # "type=gha,scope=node/16,mode=max"
  ]
}
