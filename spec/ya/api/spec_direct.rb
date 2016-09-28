require 'ya-api-direct'
require 'minitest/autorun'
require 'webmock/minitest'


describe Ya::API::Direct::Client do
  Token = "TOKEN"

  before do
    @units = {
        just_used: 10,
        units_left: 20828,
        units_limit: 64000
    }
    units_header = {"Units" => "%{just_used}/%{units_left}/%{units_limit}" % @units }

    @campaigns_get_body = {
    	     "result" => {
    	     	"Campaigns" => [
    	     		{
    	     		  	"Name" => "Test API Sandbox campaign 1",
    	     		  	"Id"=>152738,
    	     		  	"TextCampaign" => {
    	     		  		"BiddingStrategy" => {
    	     		  			"Network" => {
    	     		  				"NetworkDefault" => {
    	     		  					"BidPercent" => 100
    	     		  				},
    	     		  				"BiddingStrategyType" => "NETWORK_DEFAULT"
    	     		  			},
    	     		  			"Search" => {
    	     		  				"BiddingStrategyType" => "HIGHEST_POSITION"
    	     		  			}
    	      		  	}
    	     		  	}
    	     		},
    	     		{
    	     			"Name" => "Test API Sandbox campaign 2",
    	     			"Id"=>152739,
    	     			"TextCampaign" => {
    	     				"BiddingStrategy" => {
    	     					"Network" => {
    	     						"NetworkDefault" => {
    	     							"BidPercent" => 100
    	     						},
    	     						"BiddingStrategyType" => "NETWORK_DEFAULT"
    	     					},
    	     					"Search" => {
    	     						"BiddingStrategyType" => "HIGHEST_POSITION"
    	     					}
    	     				}
    	     			}
    	     		},
    	     		{
    	     			"Name" => "Test API Sandbox campaign 3",
    	     			"Id" => 152740,
    	     			"TextCampaign" => {
    	     				"BiddingStrategy" => {
    	     					"Network" => {
    	     						"NetworkDefault" => {
    	     							"BidPercent"=>100
     							},
                 "BiddingStrategyType" => "NETWORK_DEFAULT"
     						},
     						"Search" => {
     							"BiddingStrategyType"=>"HIGHEST_POSITION"
     						}
     					}
     				}
     			}
    	   	]
    	  }
    	}

      timestamp_str = Time.now.strftime("%FT%TZ")
      @timestamp = Time.parse(timestamp_str)

      @init_caching_body_v4 = {
            "data" => {
                  "Timestamp" => timestamp_str
            }
      }

      @init_caching_body_v5 = {
            "result" => {
                  "Timestamp" => timestamp_str
            }
      }

      stub_request(:post, "https://api-sandbox.direct.yandex.ru/json/v5/campaigns")
        .with(
          headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Accept-Language'=>'en', 'Authorization'=>'Bearer TOKEN', 'Client-Login'=>'', 'User-Agent'=>'Ruby'},
          body: {"method" => "get", "params"=> {}}.to_json)
        .to_return(:status => 200, 
                  body: @campaigns_get_body.to_json,
                  headers: units_header)

      stub_request(:post, "https://api-sandbox.direct.yandex.ru/json/v5/changes")
        .with(
            headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Accept-Language'=>'en', 'Authorization' => 'Bearer TOKEN' },
            body: {
                "method" => "checkDictionaries",
                "params" => {}
            }.to_json
        )
        .to_return(
                status: 200,
                body: @init_caching_body_v5.to_json,
                headers: units_header
        )

    stub_request(:post, "https://api-sandbox.direct.yandex.ru/live/v4/json")
      .with(
          headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'},
      	  body: {
            "method" => "GetCampaignsList",
            "params" => {},
            "locale" => "en",
            "token" => "TOKEN"
          }.to_json
      )
      .to_return(
          status: 200,
      	  body: @campaigns_get_body.to_json,
      	  headers: units_header
      )

    stub_request(:post, "https://api-sandbox.direct.yandex.ru/live/v4/json").
      with(
        headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'},
        body: {
          "method" => "GetChanges",
          "params" => {},
          "locale" => "en",
          "token" => "TOKEN"
          }.to_json
        )
    .to_return(
        status: 200,
        body: @init_caching_body_v4.to_json,
        headers: units_header
      )

      @clientV4 = Ya::API::Direct::Client.new(token: Token, api: :v4)
      @clientV5 = Ya::API::Direct::Client.new(token: Token)
  end

  describe "has version number" do
    refute_nil ::Ya::Api::Direct::VERSION
  end

	describe "when does a request" do
		it "works well with version 4" do
      assert @clientV4.v4.GetCampaignsList == @campaigns_get_body
		end
		it "works well with version 5" do
      assert @clientV5.campaigns.get == @campaigns_get_body
		end
	end

	describe "when units data is updated" do
    it "works well in version 4" do
      @clientV4.v4.GetCampaignsList
      assert @clientV4.units_data == @units
    end
		it "works well in version 5" do
      @clientV5.campaigns.get
      assert @clientV5.units_data == @units
		end
	end

	describe "when cache is initialised" do
		it "updates timestamp with version 4" do
      assert @clientV4.cache_timestamp == @timestamp
		end
		it "updates timestamp with version 5" do
      assert @clientV5.cache_timestamp == @timestamp
		end
	end
end
