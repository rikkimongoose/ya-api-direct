module Ya
  module API
    module Direct
      API_V5 = {
        "AdGroups" => [
           "add", "update", "delete", "get"
        ],
        "AgencyClients" => [
           "add", "update", "get"
        ],
        "Ads" => [
          "add", "update", "delete", "suspend", "resume", "archive", "unarchive", "moderate", "get"
        ],
        "AdExtensions" => [
          "add", "delete", "get"
        ],
        "AdImages" => [
          "add", "delete", "get"
        ],
        "AudienceTargets" => [
          "add", "delete", "suspend", "resume", "get", "setBids"
        ],
        "Bids" => [
          "set", "setAuto", "get"
        ],
        "BidModifiers" => [
          "add", "delete", "get", "set", "toggle"
        ],
        "Businesses" => [
          "get"
        ],
        "Campaigns" => [
            "add", "update", "delete", "suspend", "resume", "archive", "unarchive", "get"
        ],
        "Changes" => [
            "checkDictionaries", "checkCampaigns", "check"
        ],
        "Clients" => [
          "get", "update"
        ],
        "Creatives" => [
          "get"
        ],
        "Dictionaries" => [
          "get"
        ],
        "DynamicFeedAdTargets" => [
          "add", "delete", "suspend", "resume", "get", "setBids"
        ],
        "DynamicTextAdTargets" => [
          "add", "delete", "suspend", "resume", "get", "setBids"
        ],
        "Feeds" => [
          "add", "delete", "get", "update"
        ],
        "Keywords" => [
          "add", "update", "delete", "suspend", "resume", "get"
        ],
        "KeywordBids" => [
          "set", "setAuto", "get"
        ],
        "KeywordsResearch" => [
          "hasSearchVolume", "deduplicate"
        ],
        "Leads" => [
          "get"
        ],
        "NegativeKeywordSharedSets" => [
          "add", "update", "delete", "get"
        ],
        "RetargetingLists" => [
          "add", "update", "delete", "get"
        ],
        "Sitelinks" => [
          "add", "get", "delete"
        ],
        "SmartAdTargets" => [
          "add", "update", "setBids", "delete", "suspend", "resume", "get"
        ],
        "TurboPages" => [
          "get"
        ],
        "VCards" => [
          "add", "get", "delete"
        ],
        "Reports" => ["get"]
      }

      API_V4 = [
        "GetBalance",
        "GetSummaryStat",
        "CreateNewReport",
        "DeleteReport",
        "GetReportList",

        "CreateNewWordstatReport",
        "DeleteWordstatReport",
        "GetWordstatReport",
        "GetWordstatReportList",

        "GetKeywordsSuggestion",

        "CreateNewForecast",
        "DeleteForecastReport",
        "GetForecast",
        "GetForecastList",

        "CreateInvoice",
        "TransferMoney",
        "GetCreditLimits",
        "PayCampaigns",

        "GetClientsUnits",
        "GetSubClients",
        "GetClientInfo",
        "UpdateClientInfo",

        "CreateNewSubclient",
        "GetClientsList",

        "GetRegions",
        "GetRubrics",
        "GetTimeZones",
        "GetStatGoals",

        "GetAvailableVersions",
        "GetVersion",
        "PingAPI",
      ]


      API_V4_LIVE = [
        "CreateOrUpdateCampaign",
        "GetCampaignsList",
        "GetSummaryStat",
        "GetCampaignsListFilter",
        "GetCampaignsParams",
        "DeleteCampaign",

        "CreateOrUpdateBanners",
        "GetBanners",
        "GetBannerPhrases",
        "GetBannerPhrasesFilter",
        "DeleteBanners",
        "Keyword",

        "ModerateBanners",
        "ResumeBanners",
        "StopBanners",
        "ArchiveBanners",
        "UnArchiveBanners",

        "SetAutoPrice",
        "UpdatePrices",

        "GetBannersStat",

        "ResumeCampaign",
        "StopCampaign",
        "ArchiveCampaign",
        "UnArchiveCampaign",

        "GetBannersTags",
        "UpdateBannersTags",
        "GetCampaignsTags",
        "UpdateCampaignsTags",

        "AdImage",
        "AdImageAssociation",

        "GetRetargetingGoals",
        "RetargetingCondition",
        "Retargeting",

        "EnableSharedAccount",
        "AccountManagement",

        "GetChanges",
        "GetEventsLog",
      ]
    end
  end
end
