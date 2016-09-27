require "ya/api/direct/constants"
require "ya/api/direct/direct_service_base"

module Ya::API::Direct
  class DirectServiceV5 < DirectServiceBase
    attr_reader :service, :service_url

    def initialize(client, service, methods)
      super(client, methods)
      @service = service
      @service_url = service.downcase
      @version = :v5
    end

    def exec_request(method, request_body={})
      @client.gateway.request method, request_body, @service_url, @version
    end
  end
end