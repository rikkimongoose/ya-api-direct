module Ya
  module API
    module Direct
      API_V5 = {
        "AdGroups" => [
	       "add", "update", "delete", "get"
        ],
        "Ads" => [
          "add", "update", "delete", "suspend", "resume", "archive", "unarchive", "moderate", "get"
        ],
        "Bids" => [
          "set", "setAuto", "get"
        ],
        "BidModifiers" => [
            "add", "delete", "get", "set", "toggle"
          ],
        "Campaigns" => [
            "add", "update", "delete", "suspend", "resume", "archive", "unarchive", "get"
          ],
        "Changes" => [
            "checkDictionaries", "checkCampaigns", "check"
          ],
        "Dictionaries" => [
            "get"
        ],
        "DynamicTextAdTargets" => [
          "add", "delete", "suspend", "resume", "get", "setBids"
        ],
        "Keywords" => [
          "add", "update", "delete", "suspend", "resume", "get"
        ],
        "KeywordsResearch" => [
          "hasSearchVolume"
        ],
        "Sitelinks" => [
          "add", "get", "delete"
        ],
        "VCards" => [
          "add", "get", "delete"
        ]
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
