module NexusRepoManager
  class DockerRepo < Repo
    def initialize(data)
      super
      @docker = data['docker']
      @docker_proxy = data['dockerProxy']
    end

    def generate_options
      options = super
      options['docker'] = @docker unless @docker.nil?
      options['dockerProxy'] = @docker_proxy unless @docker_proxy.nil?
      unless options['httpClient'].nil?
        unless options['httpClient']['authentication'].nil?
          unless options['dockerProxy'].nil?
            if options['dockerProxy']['indexType'] == 'HUB'
              options['httpClient']['authentication']['username'] = ENV["DOCKER_HUB_USERNAME"]
              options['httpClient']['authentication']['password'] = ENV["DOCKER_HUB_PASSWORD"]
            end
          end
        end
      end
      options
    end
  end
end
