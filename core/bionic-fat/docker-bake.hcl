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
  tags = ["127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/core:bionic-fat"]
  context = "${PWD}/core/bionic-fat"
  platforms = ["linux/amd64", "linux/arm64"]
  cache-from = ["type=gha,scope=core/bionic-fat"]
  cache-to = ["type=gha,scope=core/bionic-fat,mode=max"]
}
