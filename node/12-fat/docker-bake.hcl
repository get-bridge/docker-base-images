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
  tags = ["127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:12-fat", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:12-fat-bionic", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:12.22.12-fat", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:12.22.12-fat-bionic"]
  context = "${PWD}/node/12-fat"
  platforms = ["linux/amd64", "linux/arm64"]
  cache-from = [
    "type=gha,scope=node/12-fat",
    "type=registry,ref=ghcr.io/get-bridge/node:12-fat-cache"
  ]
  cache-to = [
    "type=gha,scope=node/12-fat,mode=max"
  ]
}
