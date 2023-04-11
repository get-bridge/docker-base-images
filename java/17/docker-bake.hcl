# GENERATED FILE, DO NOT MODIFY!
# To update this file please edit the relevant template and run the generation
# task `rake generate:java`

# https://docs.docker.com/engine/reference/commandline/buildx_bake/#file-definition

variable "PWD" {default="" }

group "default" {
  targets = ["java"]
}

# NOTE: the context is required for now due to https://github.com/docker/buildx/issues/1028
target "java" {
  tags = ["127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/java:17", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/java:17-jdk", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/java:17-jdk-jammy"]
  context = "${PWD}/java/17"
  platforms = ["linux/amd64", "linux/arm64"]
  cache-from = [
    "type=registry,ref=ghcr.io/get-bridge/java:17-cache"
  ]
  cache-to = [
    "type=gha,scope=java/17,mode=max"
  ]
}
