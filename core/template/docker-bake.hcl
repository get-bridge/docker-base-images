<%= generation_message %>

# https://docs.docker.com/engine/reference/commandline/buildx_bake/#file-definition
<%
# Specify any additional tags here, see defaults defined in lib/metadata.rb
core_tags = []
custom_tags = docker_tags(core_tags)
%>

variable "PWD" {default="" }
variable "CI_BUILDX_CACHE" {default=false }

group "default" {
    targets = ["<%= image_name %>"]
}

# NOTE: the context is required for now due to https://github.com/docker/buildx/issues/1028
target "<%= image_name %>" {
    tags = <%= custom_tags %>
    context = "${PWD}/<%= image_name %>/<%= version %>"
    platforms = ["linux/amd64", "linux/arm64"]
    cache-from = [equal(true,CI_BUILDX_CACHE) ? "type=local,src=/tmp/.buildx-cache": "",]
    cache-to = [equal(true,CI_BUILDX_CACHE) ? "type=local,dest=/tmp/.buildx-cache-new,mode=max": ""]
}
