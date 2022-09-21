# GENERATED FILE, DO NOT MODIFY!
# To update this file please edit the relevant template and run the generation
# task `rake generate:clojure`

# https://docs.docker.com/engine/reference/commandline/buildx_bake/#file-definition

variable "PWD" {default="" }

group "default" {
  targets = ["clojure"]
}

# NOTE: the context is required for now due to https://github.com/docker/buildx/issues/1028
target "clojure" {
  tags = ["127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/clojure:11", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/clojure:11-", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/clojure:11--jammy", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/clojure:11--lein2.9.1", "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/clojure:11--lein2.9.1-jammy"]
  context = "${PWD}/clojure/11"
  platforms = ["linux/amd64", "linux/arm64"]
  cache-from = [
      "type=gha,scope=clojure/11"
  ]
  cache-to = [
      "type=gha,scope=clojure/11,mode=max"
  ]
}
