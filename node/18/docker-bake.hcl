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
  tags = ["127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:18", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:18-slim", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:18-slim-lunar", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:18.16.0-slim", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:18.16.0-slim-lunar"]
  context = "${PWD}/node/18"
  platforms = ["linux/amd64", "linux/arm64"]
  cache-from = [
    "type=gha,scope=node/18",
    "type=registry,ref=ghcr.io/get-bridge/node:18-cache"
  ]
  cache-to = [
    # disabled while GitHub Actions cache is cranky
    # "type=gha,scope=node/18,mode=max"
  ]
}
