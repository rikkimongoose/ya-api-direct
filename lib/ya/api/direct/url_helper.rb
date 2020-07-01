require "json"

require "ya/api/direct/exceptions"


module Ya::API::Direct
  RegExUnits = Regexp.new /(\d+)\/(\d+)\/(\d+)/
  # Static class with helping functions for url formatting.
  #
  # @author Rikki Mongoose
	class UrlHelper
      # Generate Yandex Direct API url for a call
      #
      # @param mode [Symbol] Direct API mode, `:sandbox` or `:production`
      # @param mode [Symbol] Direct API version, `:v5` or `:v4` or `:v4live`
      # @param mode [Symbol] Direct API service to use
      # @return [String] Generated Yandex Direct API URL
  		def self.direct_api_url(mode = :sandbox, version = :v5, service = "")
        format = :json
  			protocol = "https"
  			api_prefixes = {
  				sandbox: "api-sandbox",
  				production: "api"
  			}
        api_prefix = api_prefixes[mode || :sandbox]
        site = "%{api}.direct.yandex.ru" % {api: api_prefix}
  			api_urls = {
  				v4: {
  					json: '%{protocol}://%{site}/v4/json',
  					soap: '%{protocol}://%{site}/v4/soap',
  					wsdl: '%{protocol}://%{site}/v4/wsdl',
  					},
  				v4live: {
  					json: '%{protocol}://%{site}/live/v4/json',
  					soap: '%{protocol}://%{site}/live/v4/soap',
  					wsdl: '%{protocol}://%{site}/live/v4/wsdl',
  					},
  				v5: {
  					json: '%{protocol}://%{site}/json/v5/%{service}',
  					soap: '%{protocol}://%{site}/v5/%{service}',
  					wsdl: '%{protocol}://%{site}/v5/%{service}?wsdl',
  				    }
  				}
        api_urls[version][format] % {
          protocol: protocol,
          site: site,
          service: service
        }

  	end

    # Extract Yandex Direct API units values from responce HTTP header
    #
    # @param responce_header [Hash] Yandex Direct API response header
    # @return [Hash] Units data, extracted from header
    def self.extract_response_units(response_header)
      matched = RegExUnits.match response_header["Units"]
      matched.nil? ? {} :
      {
        just_used: matched[1].to_i,
        units_left: matched[2].to_i,
        units_limit: matched[3].to_i
      }
    end

    private

    def self.parse_data(response, ver)
      if response["Content-Type"].start_with?("application/json")
        response_body = JSON.parse(response.body)
        validate_response! response_body
        result = { data: response_body }
        if [:v5].include? ver
          result.merge!({ units_data: self.extract_response_units(response) })
        end
        result
      else
        {data: from_tsv_to_json(response.body)}
      end
    end

    def self.validate_response!(response_body)
      if response_body.has_key? 'error'
        raise Exception.new( response_body['error'] )
      end
    end

    def self.from_tsv_to_json(response_body)
      report_name = response_body.slice!(/^(.+?)\n/)
      keys = response_body.slice!(/^(.+?)\n/).split("\t")
      rows = response_body.match(/rows:(.+?)\n/)[1].to_i
      values = []
      rows.times do |row|
        hash_values = {}
        response_body.slice!(/^(.+?)\n/).split("\t").each_with_index do |value, index|
          hash_values[keys[index].gsub("\n", "")] = value.gsub("\n", "")
        end
        values.push(hash_values)
      end
      values
    end
	end
end
