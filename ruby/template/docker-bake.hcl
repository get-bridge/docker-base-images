# https://docs.docker.com/engine/reference/commandline/buildx_bake/#file-definition
<%
# Specify any additional tags here, see defaults defined in lib/metadata.rb
ruby_tags = [
    "#{full_ecr_path}:#{ruby_version}",
    "#{full_ecr_path}:#{ruby_version}-#{flavor}",
    "#{full_ecr_path}:#{ruby_version}-#{flavor}-#{distribution_code_name}",
    "#{full_ecr_path}:#{ruby_major}-#{flavor}",
    "#{full_ecr_path}:#{ruby_major}-#{flavor}-#{distribution_code_name}"
]
custom_tags = docker_tags(ruby_tags)
%>

variable "PWD" {default="" }

group "default" {
    targets = ["<%= image_name %>"]
}

# NOTE: the context is required for now due to https://github.com/docker/buildx/issues/1028
target "<%= image_name %>" {
    tags = <%= custom_tags %>
    context = "${PWD}/<%= image_name %>/<%= version %>"
    platforms = ["linux/amd64", "linux/arm64"]
    <% if ENV.fetch('CI_BUILDX_CACHE', false) -%>

    cache-from = ["type=local,src=/tmp/.buildx-cache"]
    cache-to = ["type=local,dest=/tmp/.buildx-cache-new,mode=max"]
    <% end -%>
}
