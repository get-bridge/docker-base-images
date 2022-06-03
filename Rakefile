# frozen_string_literal: true

# STDLIB stuffs
require 'fileutils'
require 'json'
require 'pathname'
require 'yaml'

# Additional rake tasks
require 'rubocop/rake_task'

# Local stuffs
require_relative 'lib/ecr'
require_relative 'lib/generation_message'
require_relative 'lib/template'

task default: 'generate:all'

PROJECT_DIR = File.dirname(__FILE__)
PROJECT_PATHNAME = Pathname.new(PROJECT_DIR)
BAKE_FILE = 'docker-bake.hcl'
MANIFEST = YAML.load_file(File.join(PROJECT_DIR, 'manifest.yml'))

# Get global defaults, and delete from yml so they are not translated into a docker image
GLOBAL_DEFAULTS = MANIFEST.delete('globals')

def build_output_path(*parts)
  File.join(PROJECT_DIR, *parts)
end

def build_template_dir(image_name)
  File.join(image_name, 'template')
end

def with_clean_output_dir(*path_parts)
  output_dir = build_output_path(*path_parts)
  FileUtils.rm_r(output_dir) if File.exist?(output_dir)
  FileUtils.mkdir_p(output_dir)
  yield output_dir
end

RuboCop::RakeTask.new

# rubocop:disable Metrics/BlockLength
namespace :ci do
  desc 'Generate index of bake files and set-matrix output'
  task 'set-matrix' do
    dockerfiles = Dir.glob(File.join(PROJECT_DIR, '**', 'Dockerfile')).reject do |path|
      path.include?('template') ||
        path.include?('ci') ||
        path.include?('core') || # We specify the core files in the first CI job, as they need to be built first
        path.include?('examples')
    end

    docker_contexts = dockerfiles.map do |path|
      Pathname.new(path).relative_path_from(PROJECT_PATHNAME).dirname + BAKE_FILE
    end.to_json

    puts 'setting matrix output'
    system('echo', "::set-output name=matrix::#{docker_contexts}")
  end
end

namespace :ecr do
  desc 'Ensure all ecr repositories exist'
  task 'create_if_missing' do
    repository_names = MANIFEST.map do |image_name, _details|
      "get-bridge/#{image_name}"
    end

    Ecr.new(dry_run: false).create_if_missing(repository_names: repository_names)
  end
end

namespace :generate do
  MANIFEST.each do |image_name, details|
    desc "Generate all #{image_name} Dockerfiles"
    task image_name do |t|
      puts "Generating #{image_name} Dockerfiles"
      template_dir = build_template_dir(image_name)
      generation_message = GenerationMessage.new(t.name).render

      template_filenames = details.fetch('template_files') { [] }
      template_filenames << 'Dockerfile' unless template_filenames.include?('Dockerfile')
      template_filenames << 'docker-bake.hcl' unless template_filenames.include?('docker-bake.hcl')
      templates = template_filenames.map { |filename| Template.new(File.join(template_dir, filename)) }

      defaults = details.fetch('defaults', {})
      details['versions'].each do |version, values|
        print "- #{version}... "
        values ||= {}
        with_clean_output_dir(image_name, version) do |output_dir|
          version = values['version_override'] if values['version_override']
          template_values = GLOBAL_DEFAULTS
                            .fetch('defaults', {})
                            .merge(defaults)
                            .merge(values)
                            .merge(
                              generation_message: generation_message,
                              version: version,
                              image_name: image_name,
                              output_dir: output_dir
                            )
          templates.each do |template|
            template.render(template_values).to(output_dir)
          end
          files_to_copy = Dir.glob(File.join(template_dir, '**')).reject do |path|
            templates.any? { |template| File.identical?(path, template.path) }
          end
          FileUtils.cp_r(files_to_copy, output_dir, preserve: true)
        end
        puts 'Done!'
      end
    end
  end

  # This one must be last for the dependency resolution magic to work
  desc 'Generate all templatized Dockerfiles'
  task 'all' => Rake.application.tasks.select { |t| t.name.start_with?('generate') }.map(&:name)
end
# rubocop:enable Metrics/BlockLength
