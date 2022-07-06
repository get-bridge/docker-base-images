# https://docs.docker.com/engine/reference/commandline/buildx_bake/#file-definition


variable "PWD" {default="" }
variable "CI_BUILDX_CACHE" {default=false }

group "default" {
    targets = ["ruby"]
}

# NOTE: the context is required for now due to https://github.com/docker/buildx/issues/1028
target "ruby" {
    tags = ["127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:3.0-fat", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:3.0-fat-jammy", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:3.0.4-fat", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:3.0.4-fat-jammy"]
    context = "${PWD}/ruby/3.0-fat"
    platforms = ["linux/amd64", "linux/arm64"]
    cache-from = [equal(true,CI_BUILDX_CACHE) ? "type=local,src=/tmp/.buildx-cache": "",]
    cache-to = [equal(true,CI_BUILDX_CACHE) ? "type=local,dest=/tmp/.buildx-cache-new,mode=max": ""]
}
