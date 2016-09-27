# ya-api-direct
A Ruby interface to Yandex Direct API

## Installation

Add this line to your application's Gemfile:

    gem 'ya-api-direct'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ya_direct_api

Test with rake:

    $ rake

## Usage

OAuth2 Yandex token is needed. Use [omniauth-yandex](https://github.com/evrone/omniauth-yandex/) to receive it. Install it according by following manual: [Rails Authentication with OAuth 2.0 and OmniAuth](https://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/).

Call methods of Yandex Direct API 5:

```ruby
request = {
    "SelectionCriteria" => {
      "Types" => ["TEXT_CAMPAIGN"]
    },
    "FieldNames" => ["Id", "Name"],
    "TextCampaignFieldNames" => ["BiddingStrategy"]
}

@direct = Ya::API::Direct::Client.new({ token: Token })
json = direct.campaigns.get request
```

Call methods from versions 4 and 4 Live:

```ruby
@direct = Ya::API::Direct::Client.new({ token: Token })
json = direct.v4.GetCampaignsList []
```

All names of controllers and methods are equal to ones from Direct API help. 4 vs 4 Live is autodetected.

## Caching

By default the client class sends request to clients. You can avoid it by turning this option off, like this:


```ruby
@direct = Ya::API::Direct::Client.new({ token: Token, cache: false })
```

Check [Yandex manuals](https://yandex.ru/adv/edu/direct-api/kak-ispolzovat-api-effektivno-ogranicheniya-i-rekomendatsii) for more info on caching.

Date returned with first call of caching method is stored in ``cache_timestamp`` property.

## Units data

Units data of last request is stored in ``units_data`` property. There're 3 keys in this hash:
* ``just_used``
* ``units_left``
* ``units_limit``

## Useful links

* [Intruduction to Yandex Direct API](https://yandex.ru/adv/edu/direct-api)
* [Yandex Direct API 5 manual](https://tech.yandex.ru/direct/doc/dg/concepts/about-docpage/)
* [Yandex Direct API 4 and 4 Live manual](https://tech.yandex.ru/direct/doc/dg-v4/concepts/About-docpage/)

## Contributing

1. Fork it ( http://github.com/rikkimongoose/ya-api-direct/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
