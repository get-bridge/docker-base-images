# GENERATED FILE, DO NOT MODIFY!
# To update this file please edit the relevant template and run the generation
# task `rake generate:ruby-passenger`

# https://docs.docker.com/engine/reference/commandline/buildx_bake/#file-definition

variable "PWD" {default="" }

group "default" {
    targets = ["ruby-passenger"]
}

# NOTE: the context is required for now due to https://github.com/docker/buildx/issues/1028
target "ruby-passenger" {
    tags = ["127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby-passenger:2.7-fat", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby-passenger:2.7-fat-slim", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby-passenger:2.7-slim", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby-passenger:2.7-slim-jammy", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby-passenger:2.7.6", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby-passenger:2.7.6-slim", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby-passenger:2.7.6-slim-jammy"]
    context = "${PWD}/ruby-passenger/2.7-fat"
    platforms = ["linux/amd64", "linux/arm64"]
    cache-from = [
        "type=gha,scope=ruby-passenger/2.7-fat"
    ]
    cache-to = [
        "type=gha,scope=ruby-passenger/2.7-fat,mode=max"
    ]
}
