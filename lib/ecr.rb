# frozen_string_literal: true

require 'aws-sdk-ecr'
require 'json'

class Ecr
  attr_reader :client, :dry_run

  def initialize(dry_run: true, **opts)
    default_options = { region: 'us-east-2' }.merge(opts)
    @dry_run = dry_run
    @client = Aws::ECR::Client.new(default_options)
  end

  def create_if_missing(repository_names: [])
    unless repository_names.is_a?(Array) && repository_names.count.positive?
      raise 'Argument must be a non empty Array<String>'
    end

    diff = repository_names.sort - ecr_respository_names
    if diff.count.positive?
      create_repository(repository_names: diff)
    else
      puts 'All repositories have been created'
    end
  end

  private

  def ecr_respository_names
    results = []
    response = describe_repositories(max_results: 100)
    results << response.to_h[:repositories]
    while response.next_page?
      response = response.next_page
      results << response.to_h[:repositories]
    end

    results.map do |result|
      result.collect { |r| r[:repository_name] }
    end.flatten.sort
  end

  def describe_repositories(**opts)
    default_options = {}.merge(opts)
    client.describe_repositories(default_options)
  end

  def create_repository(repository_names:, **opts) # rubocop:disable Metrics/MethodLength
    default_options = {
      registry_id: '127178877223', # bridge-shared
      image_tag_mutability: 'MUTABLE',
      image_scanning_configuration: { scan_on_push: true },
      encryption_configuration: { encryption_type: 'AES256' }
    }.merge(opts)
    repository_names.each do |repository|
      default_options = default_options.merge(repository_name: repository)
      puts "creating #{default_options} #{dry_run ? '(dry run)' : nil}"
      client.create_repository(default_options) unless dry_run
    end
  rescue Aws::ECR::Errors::RepositoryAlreadyExistsException => e
    puts e.message
  end
end
