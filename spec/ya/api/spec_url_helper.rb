require 'ya/api/direct'
require 'minitest/autorun'
require 'minitest/spec'

describe Ya::API::Direct::UrlHelper do
	describe "when generates URL by params" do
		it "generates right URL for v5" do
			assert_equal Ya::API::Direct::UrlHelper.direct_api_url(:production, :v5, "ads"), "https://api.direct.yandex.ru/json/v5/ads"
		end
		it "generates right URL for v4" do
			assert_equal Ya::API::Direct::UrlHelper.direct_api_url(:production, :v4, "GetBalance"), "https://api.direct.yandex.ru/v4/json"
		end
		it "generates right URL for v4 live" do
			assert_equal Ya::API::Direct::UrlHelper.direct_api_url(:production, :v4live, "GetCampaignsList"), "https://api.direct.yandex.ru/live/v4/json"
		end
		it "generates right URL for v5 sandbox" do
			assert_equal Ya::API::Direct::UrlHelper.direct_api_url(:sandbox, :v5, "ads"), "https://api-sandbox.direct.yandex.ru/json/v5/ads"
		end
		it "generates right URL for v4 sandbox" do
			assert_equal Ya::API::Direct::UrlHelper.direct_api_url(:sandbox, :v4, "GetBalance"), "https://api-sandbox.direct.yandex.ru/v4/json"
		end
		it "generates right URL for v4 live sandbox" do
			assert_equal Ya::API::Direct::UrlHelper.direct_api_url(:sandbox, :v4live, "GetCampaignsList"), "https://api-sandbox.direct.yandex.ru/live/v4/json"
		end
	end
	describe "when parses units block" do
		response = {"Units" => "10/20828/64000"}
		units_data = Ya::API::Direct::UrlHelper.extract_response_units response
		it "parses it right way" do
			assert_equal units_data[:just_used], 10
			assert_equal units_data[:units_left], 20828
			assert_equal units_data[:units_limit], 64000
		end
	end
end