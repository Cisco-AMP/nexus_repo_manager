module NexusRepoManager
  class MavenRepo < Repo
    def initialize(data)
      super
      @maven = data['maven']
    end

    def generate_options
      options = super
      options['maven'] = @maven unless @maven.nil?
      options
    end
  end
end
