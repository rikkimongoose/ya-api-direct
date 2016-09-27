require "ya/api/direct/constants"
require "ya/api/direct/gateway"
require "ya/api/direct/direct_service_v4"
require "ya/api/direct/direct_service_v5"
require "ya/api/direct/exception"

module Ya::API::Direct
  AllowedAPIVersions = [:v5, :v4]

  # Yandex Direct API client class
  # @author RikkiMongoose
  class Client
    attr_reader :cache_timestamp, :units_data, :gateway,
                :v4, :v5
    
    # Initializes a new Client object
    #
    # @param config [Hash]
    # @return [Ya::API::Direct::Client]
    def initialize(config = {})
      @config = {
        token: nil,
        app_id: nil,
        login: '',
        locale: 'en',
        mode: :sandbox,
        format: :json,
        cache: true,
        api: :v5,
        ssl: true
      }.merge(config)

      @units_data = {
        just_used: nil,
        units_left: nil,
        units_limit: nil
      }

      raise "Token can't be empty" if @config[:token].nil?
      raise "Allowed Yandex Direct API versions are #{AllowedVersions}" unless AllowedAPIVersions.include? @config[:api]

      @gateway = Ya::API::Direct::Gateway.new @config

      init_v4
      init_v5
      start_cache! if @config[:cache]
      yield self if block_given?
    end

    # Update units data.
    #
    # @param format [Hash] New units data values
    # @return [Hash] Updated user data values
    def update_units_data(units_data = {})
      @units_data.merge! units_data
    end

    # Start caching. Executed automatically, if @congif[:cache] is true.
    #
    # @return [String] New timestamp value.
    def start_cache!
      case @config[:api]
      when :v4
        result = @gateway.request("GetChanges", {}, nil, :v4live)
        timestamp = result[:data]['data']['Timestamp']
      when :v5
        result = @gateway.request("checkDictionaries", {}, "changes", :v5)
        timestamp = result[:data]['result']['Timestamp']
      end
      @cache_timestamp = Time.parse(timestamp)
      update_units_data result[:units_data]
      @cache_timestamp
    end

    private
    
    def init_v4
      @v4 = DirectServiceV4.new self, (API_V4 + API_V4_LIVE)
    end

    def init_v5
      @v5 = {}
      API_V5.each do |service, methods|
        service_item = DirectServiceV5.new(self, service, methods)
        service_key = service_item.service_url
        @v5[service_key] = service_item
        self.class.send :define_method, service_key do @v5[service_key] end
      end
    end
  end
end