<%= generation_message -%>

# https://docs.docker.com/engine/reference/commandline/buildx_bake/#file-definition
<%
# Specify any additional tags here, see defaults defined in lib/metadata.rb
ruby_tags = [
  "#{full_ecr_path}:#{ruby_version}-#{flavor}",
  "#{full_ecr_path}:#{ruby_version}-#{flavor}-#{distribution_code_name}",
  "#{full_ecr_path}:#{ruby_major}-#{flavor}",
  "#{full_ecr_path}:#{ruby_major}-#{flavor}-#{distribution_code_name}"
]
ruby_tags.push("#{full_ecr_path}:#{ruby_version}") if flavor&.casecmp('slim')&.zero?
custom_tags = docker_tags(ruby_tags)
-%>

variable "PWD" {default="" }

group "default" {
  targets = ["<%= image_name %>"]
}

# NOTE: the context is required for now due to https://github.com/docker/buildx/issues/1028
target "<%= image_name %>" {
  tags = <%= custom_tags %>
  context = "${PWD}/<%= image_name %>/<%= version %>"
  platforms = ["linux/amd64", "linux/arm64"]
  cache-from = [
    "type=gha,scope=<%= image_name %>/<%= version %>",
    "type=registry,ref=<%= full_ecr_path%>/<%= image_name %>/<%= version %>:cache"
  ]
  cache-to = [
    "type=gha,scope=<%= image_name %>/<%= version %>,mode=max",
    "type=registry,ref=<%= full_ecr_path%>/<%= image_name %>/<%= version %>:cache,mode=max"
  ]
}
