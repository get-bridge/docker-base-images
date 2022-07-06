# GENERATED FILE, DO NOT MODIFY!
# To update this file please edit the relevant template and run the generation
# task `rake generate:ruby`

# https://docs.docker.com/engine/reference/commandline/buildx_bake/#file-definition

variable "PWD" {default="" }
variable "CI_BUILDX_CACHE" {default=false }

group "default" {
    targets = ["ruby"]
}

# NOTE: the context is required for now due to https://github.com/docker/buildx/issues/1028
target "ruby" {
    tags = ["127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:2.7", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:2.7-slim", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:2.7-slim-jammy", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:2.7.6", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:2.7.6-slim", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:2.7.6-slim-jammy"]
    context = "${PWD}/ruby/2.7"
    platforms = ["linux/amd64", "linux/arm64"]
    cache-from = [equal(true,CI_BUILDX_CACHE) ? "type=local,src=/tmp/.buildx-cache": "",]
    cache-to = [equal(true,CI_BUILDX_CACHE) ? "type=local,dest=/tmp/.buildx-cache-new,mode=max": ""]
}
