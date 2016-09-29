require "ya/api/direct/constants"

module Ya::API::Direct
  class DirectServiceBase
    attr_reader :method_items, :version
    def initialize(client, methods)
      @client = client
      @method_items = methods
      init_methods
    end

    protected
    def init_methods
      @method_items.each do |method|
        self.class.send :define_method, method do |params = {}|
          result = exec_request(method, params || {})
          callback_by_result result
          result[:data]
        end
      end
    end

    def exec_request(method, request_body)
      client.gateway.request method, request_body, @version
    end

    def callback_by_result(result={})
    end
  end
end