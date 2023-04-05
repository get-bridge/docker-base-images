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
    tags = ["127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:14-yarn", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:14-yarn-jammy", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:14.21.3-yarn", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/node:14.21.3-yarn-jammy"]
    context = "${PWD}/node/14-yarn"
    platforms = ["linux/amd64", "linux/arm64"]
    cache-from = [
        "type=gha,scope=node/14-yarn"
    ]
    cache-to = [
        "type=gha,scope=node/14-yarn,mode=max"
    ]
}
