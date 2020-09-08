require 'nexus_api'
require 'dotenv/load'
require 'pry'
require 'psych'

module NexusRepoManager
  class CommandCentre
    attr_accessor :nexus_api, :repos

    NEXUS_USERNAME = ENV['NEXUS_USERNAME']
    NEXUS_PASSWORD = ENV['NEXUS_PASSWORD']
    NEXUS_HOSTNAME = ENV['NEXUS_HOSTNAME']

    def initialize(env)
      @nexus_api = NexusAPI::API.new(
        username: NEXUS_USERNAME,
        password: NEXUS_PASSWORD,
        hostname: NEXUS_HOSTNAME
      )

      json_file = File.read(File.join(__dir__, "../../configs/#{env}.json"))
      @config = JSON.parse(json_file)
      @repos = @config.map { |data| NexusRepoManager::RepoFactory.build_repo(data) }
    end

    def all_repo_names
      @nexus_api.list_repository_names
    end

    def run
      existing_repos = all_repo_names
      sorted_repos.each do |repo|
        message_base = "#{repo.format} #{repo.type} repository '#{repo.name}'..."
        if existing_repos.include?(repo.name)
          puts "- Repo already exists; Skipping #{message_base}"
        else
          puts "- Creating #{repo.format} #{repo.type} repository '#{repo.name}'..."
          unless repo.create(@nexus_api)
            puts "  WARNING: Failed to create #{repo.format} #{repo.type} repository '#{repo.name}'."
            puts "           Please check the repo configuration and the Nexus logs."
          end
        end
      end
    end

    private

    def sorted_repos
      group_repos = []
      non_group_repos = []
      @repos.each do |repo|
        if repo.type == 'group'
          group_repos << repo
        else
          non_group_repos << repo
        end
      end
      non_group_repos + group_repos
    end
  end
end
