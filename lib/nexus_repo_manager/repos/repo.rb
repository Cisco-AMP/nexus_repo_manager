module NexusRepoManager
  class Repo
    attr_accessor :name, :format, :type

    def initialize(data)
      # Required
      @name = data['name']
      @format = data['format']
      @type = data['type']

      # Not required
      @url = data['url']

      # Optional
      @online = data['online']
      @storage = data['storage']
      @cleanup = data['cleanup']
      @group = data['group']
      @proxy = data['proxy']
      @negative_cache = data['negativeCache']
      @http_client = data['httpClient']
      @routing_rule = data['routingRule']
    end

    def create(api)
      method_name = build_method_name
      case @type
      when 'group'
        api.send(
          method_name,
          name: @name,
          members: generate_group_members,
          options: generate_options
        )
      when 'hosted'
        api.send(
          method_name,
          name: @name,
          options: generate_options
        )
      when 'proxy'
        api.send(
          method_name,
          name: @name,
          remote_url: generate_proxy_url,
          options: generate_options
        )
      else
        unsupported_type
      end
    end

    private

    def build_method_name
      format = @format == 'maven2' ? 'maven' : @format
      "create_repository_#{format}_#{@type}".to_sym
    end

    def generate_group_members
      if @group['memberNames'].empty?
        puts "  ERROR: ['group']['memberNames'] cannot be an empty array."
        exit(1)
      end
      @group['memberNames']
    end

    def generate_proxy_url
      @proxy['remoteUrl']
    end

    def generate_options
      options = {}
      options['online'] = @online unless @online.nil?
      options['storage'] = @storage unless @storage.nil?
      options['cleanup'] = @cleanup unless @cleanup.nil?
      options['group'] = @group unless @group.nil?
      options['proxy'] = @proxy unless @proxy.nil?
      options['negativeCache'] = @negative_cache unless @negative_cache.nil?
      options['httpClient'] = @http_client unless @http_client.nil?
      options['routingRule'] = @routing_rule unless @routing_rule.nil?
      options
    end

    def unsupported_type
        puts "  ERROR: The '#{@type}' repository type is unsupported.\n"\
             "         Please correct the type in the config or open a\n"\
             "         ticket with Release Engineering to add support."
        exit(1)
    end
  end
end
