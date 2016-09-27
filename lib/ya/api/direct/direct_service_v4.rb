require "ya/api/direct/constants"
require "ya/api/direct/direct_service_base"

module Ya::API::Direct
  class DirectServiceV4 < DirectServiceBase

    def initialize(client, methods, version = :v4)
      super(client, methods)
      @version = version
    end

    def exec_request(method, request_body = {})
      @client.gateway.request method, request_body, nil, (API_V4_LIVE.include?(method) ? :v4live : @version)
    end
  end
end