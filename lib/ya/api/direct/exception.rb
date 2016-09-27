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
end