require "net/http"
require "openssl"
require "json"

require "ya/api/direct/constants"
require "ya/api/direct/url_helper"
require "ya/api/direct/exceptions"

module Ya::API::Direct
  class Gateway
    attr_reader :config, :response
    def initialize(config)
      @config = config
    end

    def request(method, params, service = "", version = nil)
      ver = version || (service.nil? ? :v4 : :v5)
      url = UrlHelper.direct_api_url @config[:mode], ver, service
      header = generate_header ver
      body = generate_body method, params, ver
      uri = URI.parse url
      request = Net::HTTP::Post.new(uri.path, initheader = header)
      request.body = body.to_json
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = @config[:ssl] ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE

      begin
        response = http.request(request)
        if (response.kind_of? Net::HTTPCreated) || (response.kind_of? Net::HTTPAccepted)
          sleep response['retryIn'].to_i
        end
      end while(response.kind_of? Net::HTTPCreated) || (response.kind_of? Net::HTTPAccepted)

      @response = response

      if response.kind_of? Net::HTTPSuccess
        UrlHelper.parse_data response, ver
      else
        raise RequestError.new(
          method: method,
          version: ver,
          request: request,
          response: response
        )
      end
    end

    def generate_header(ver)
      header = {}
      if [:v5].include? ver
        header.merge!({
          'Client-Login' => @config[:login],
          'Accept-Language' => @config[:locale],
          'Authorization' => "Bearer %{token}" % @config
        })
      end
    end

    def generate_body(method, params, ver)
      params_key = [:v4, :v4live].include?(ver) ?  'param' : 'params'
      body = {
          'method' => method,
          params_key => params
        }
      if [:v4, :v4live].include? ver
        body.merge!({
          "locale" => @config[:locale],
          "token" => @config[:token]
        })
      end
      body
    end
  end
end
