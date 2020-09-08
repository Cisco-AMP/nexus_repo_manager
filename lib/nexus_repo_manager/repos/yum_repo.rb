module NexusRepoManager
  class YumRepo < Repo
    def initialize(data)
      super
      @yum = data['yum']
    end

    def generate_options
      options = super
      options['yum'] = @yum unless @yum.nil?
      options
    end
  end
end