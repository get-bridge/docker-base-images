require 'json'

# lib/util has shared constants and methods used in rake tasks
require_relative '../lib/util'

namespace :ci do
  namespace 'set-matrix' do
    desc 'Generate core index of bake config, cache, and set-matrix output'
    task 'core' do
      core_filter = proc { |image_name| image_name == 'core' }

      puts matrix(&core_filter).to_json
    end

    desc 'Generate non-core index of bake config, cache, and set-matrix output'
    task 'non-core' do
      non_core_filter = proc { |image_name| image_name != 'core' }

      puts matrix(&non_core_filter).to_json
    end
  end
end

# input is a proc like:
#
#     proc { |image_name| image_name == 'core' }
#
# and must be dereferenced when called:
#
#     matrix(&filter)
#
# this returns an object that looks something like:
#
# {
#   "include": [
#     {
#       "bake": "core/jammy/docker-bake.hcl",
#       "cache": [
#         "type=gha,scope=core/jammy",
#         "127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/core:jammy-cache"
#       ]
#     },
#     {...}
#   ]
# }
#
def matrix(&)
  {
    include: Util::MANIFEST.select(&).flat_map do |image_name, details|
      details.fetch('versions').keys.map do |version|
        {
          bake: Pathname.new("#{image_name}/#{version}") + Util::BAKE_FILE,
          cache: [
            "type=gha,scope=#{image_name}/#{version}",
            "#{ecr_registry}/get-bridge/#{image_name}:#{version}-cache"
          ]
        }
      end
    end
  }
end

def ecr_registry
  Util::GLOBAL_DEFAULTS.fetch('defaults').fetch('ecr_registry')
end
