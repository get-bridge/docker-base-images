# lib/util has shared constants and methods used in rake tasks
require_relative '../lib/util'
require_relative '../lib/generation_message'
require_relative '../lib/template'

# rubocop:disable Metrics/BlockLength
namespace :generate do
  Util::MANIFEST.each do |image_name, details|
    desc "Generate all #{image_name} Dockerfiles"
    task image_name do |t|
      puts "Generating #{image_name} Dockerfiles"
      template_dir = Util.build_template_dir(image_name)
      generation_message = GenerationMessage.new(t.name).render

      template_filenames = details.fetch('template_files') { [] }
      template_filenames << 'Dockerfile' unless template_filenames.include?('Dockerfile')
      template_filenames << 'docker-bake.hcl' unless template_filenames.include?('docker-bake.hcl')
      templates = template_filenames.map { |filename| Template.new(File.join(template_dir, filename)) }

      defaults = details.fetch('defaults', {})
      details.fetch('versions').each do |version, values|
        print "- #{version}... "
        values ||= {}
        Util.with_clean_output_dir(image_name, version) do |output_dir|
          version = values.fetch('version_override', version)
          template_values = Util::GLOBAL_DEFAULTS
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
