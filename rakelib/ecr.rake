# lib/util has shared constants and methods used in rake tasks
# lib/util also requires all neccesarry files

require_relative '../lib/util'
require_relative '../lib/ecr'

namespace :ecr do
  desc 'Ensure all ecr repositories exist'
  task 'create_if_missing' do
    repository_names = Util::MANIFEST.map do |image_name, _details|
      "get-bridge/#{image_name}"
    end

    Ecr.new(dry_run: false).create_if_missing(repository_names: repository_names)
  end
end
