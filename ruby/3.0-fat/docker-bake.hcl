# GENERATED FILE, DO NOT MODIFY!
# To update this file please edit the relevant template and run the generation
# task `rake generate:ruby`

# https://docs.docker.com/engine/reference/commandline/buildx_bake/#file-definition

variable "PWD" {default="" }

group "default" {
    targets = ["ruby"]
}

# NOTE: the context is required for now due to https://github.com/docker/buildx/issues/1028
target "ruby" {
    tags = ["127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:0ff24c3a3cca3f6b252128497e3910a588a763d5", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:3.0-fat", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:3.0-fat-jammy", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:3.0.4-fat", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:3.0.4-fat-jammy"]
    context = "${PWD}/ruby/3.0-fat"
    platforms = ["linux/amd64", "linux/arm64"]
    cache-from = [
        "type=gha,scope=ruby/3.0-fat"
    ]
    cache-to = [
        "type=gha,scope=ruby/3.0-fat,mode=max"
    ]
}
