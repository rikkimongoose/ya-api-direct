require "ya/api/direct/constants"

module Ya::API::Direct
  class Exception < StandardError
    attr_reader :error_detail, :error_code, :error_str

    def initialize(error_detail, error_str, error_code)
      @error_detail = error_detail
      @error_str = error_str
      @error_code = error_code
    end

    def to_s
      "#{@error_str} : #{@error_detail} : #{@error_code}"
    end
  end

  class RequestError < StandardError
    attr_reader :method, :version, :request, :response

    def initialize( method: , version: , request: , response: )
      @method = method
      @version = version
      @request = request
      @response = response
    end

    def to_s
      if response.body && ['text/json', 'application/json'].include?( response["Content-Type"] ) && error = JSON.parse( response.body )['error']
        err_msg = error.values_at('error_code', 'error_string', 'error_detail', 'request_id').reject(&:blank?).join(' : ')
      end
      [ ['HTTP ', response.code].join, err_msg ].compact.join(': ')
    end
  end
end
