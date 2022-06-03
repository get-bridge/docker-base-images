# frozen_string_literal: true

# This class could be replaced with something like OpenStruct,
# but haveing a dedicated class makes it easy to add helper methods to the ERB templates
class Metadata
  def initialize(values)
    values.each do |key, value|
      instance_variable_set(:"@#{key}", value)
      define_singleton_method(key.to_s) { value }
    end
  end

  # NOTE: see ../manifest.yml for values passed into the initialize method
  # some of the methods defined here, use those vaules if they exist
  def get_binding # rubocop:disable Naming/AccessorMethodName
    binding
  end

  # Ends up looking something like 127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge
  def ecr_namespace
    "#{ENV.fetch('ECR_REGISTRY', ecr_registry)}/get-bridge"
  end

  # Ends up looking something like 127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby
  def full_ecr_path
    "#{ecr_namespace}/#{image_name}"
  end

  def docker_tags(custom_tags = [])
    custom_tags = custom_tags.push(additional_tags).flatten.uniq
    default_docker_tags.push(custom_tags).flatten.uniq
  end

  # return nil if you try to call a method that doesn't exist
  def method_missing(_method_name, *_args, &); end
  def respond_to_missing?(_method_name); end

  private

  def github_sha
    ENV.fetch('GITHUB_SHA', nil)
  end

  def default_docker_tags
    ["#{full_ecr_path}:#{version}"].tap do |tags_array|
      tags_array.push("#{full_ecr_path}:#{github_sha}") if github_sha
      tags_array.push("#{full_ecr_path}:latest") if latest
    end
  end
end
