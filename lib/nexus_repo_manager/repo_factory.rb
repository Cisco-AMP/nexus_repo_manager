module NexusRepoManager
  class RepoFactory
    def self.build_repo(data)
      format = data['format']
      case format
      when 'docker'
        NexusRepoManager::DockerRepo.new(data)
      when 'maven2'
        NexusRepoManager::MavenRepo.new(data)
      when 'npm'
        NexusRepoManager::NpmRepo.new(data)
      when 'pypi'
        NexusRepoManager::PypiRepo.new(data)
      when 'raw'
        NexusRepoManager::RawRepo.new(data)
      when 'rubygems'
        NexusRepoManager::RubygemsRepo.new(data)
      when 'yum'
        NexusRepoManager::YumRepo.new(data)
      else
        unsupported_format
      end
    end


    private

    def self.unsupported_format
        puts "ERROR: The '#{format}' repository format is unsupported.\n"\
             "       Please correct the format in the config or open a\n"\
             "       ticket with Release Engineering to add support."
        exit(1)
    end
  end
end