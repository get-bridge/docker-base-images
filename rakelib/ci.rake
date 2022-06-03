# frozen_string_literal: true

require 'json'

# lib/util has shared constants and methods used in rake tasks
require_relative '../lib/util'

namespace :ci do
  desc 'Generate index of bake files and set-matrix output'
  task 'set-matrix' do
    dockerfiles = Dir.glob(File.join(Util::PROJECT_DIR, '**', 'Dockerfile')).reject do |path|
      path.include?('template') ||
        path.include?('ci') ||
        path.include?('core') || # We specify the core files in the first CI job, as they need to be built first
        path.include?('examples')
    end

    docker_contexts = dockerfiles.map do |path|
      Pathname.new(path).relative_path_from(Util::PROJECT_PATHNAME).dirname + Util::BAKE_FILE
    end.to_json

    puts 'setting matrix output'
    system('echo', "::set-output name=matrix::#{docker_contexts}")
  end
end
