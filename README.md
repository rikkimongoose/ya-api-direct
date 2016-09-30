# Ya::Api::Direct
A Ruby interface to Yandex Direct API. Supported versions 4, 4 Live, 5.

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/ya/api/direct`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ya-api-direct'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ya-api-direct

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

options = { token: Token }
@direct = Ya::API::Direct::Client.new(options)
json = direct.campaigns.get request
```

Call methods from versions 4 and 4 Live:

```ruby
@direct = Ya::API::Direct::Client.new({ token: Token })
json = direct.v4.GetCampaignsList
```

All names of controllers and methods are equal to ones from Direct API help. 4 vs 4 Live is autodetected.

Allowed options:
* ``token:`` Yandex Direct API token. Required field. 
* ``app_id:`` Application ID. Isn't required. Used for Yandex stat.
* ``login:`` Application login. Isn't required. Used for Yandex stat.
* ``locale:`` One of locales, supported by Yandex API ('en' or 'ru'). By default: 'en'.
* ``mode:`` Yandex Direct API server to send requests (``:sandbox`` or ``production``). By default: ``:sandbox``.
* ``cache:`` send caching request after creating the instance.  By default: ``true``.
* ``api:`` used only to make caching request (:v5 or :v4),  By default: ``:v5``.
* ``ssl:`` use SSL connection. By default: ``true``.

## Caching

By default the client class sends request to clients. You can avoid it by turning this option off, like this:


```ruby
@direct = Ya::API::Direct::Client.new({ token: Token, cache: false })
```

Check [Yandex manuals](https://yandex.ru/adv/edu/direct-api/kak-ispolzovat-api-effektivno-ogranicheniya-i-rekomendatsii) for more info on caching.

Date returned with first call of caching method is stored in ``cache_timestamp`` property.

## Units data

Units data of last request is stored in ``units_data`` property. There're 3 keys in this hash:

* ``just_used`` - units used by last request.
* ``units_left`` - units left for the current session.
* ``units_limit`` - units limit for a session of your account.

They were added only in Yandex Direct API 5. Calling the methods from 4 or 4 Live doesn't update them.

## Useful links

* [Introduction to Yandex Direct API](https://yandex.ru/adv/edu/direct-api)
* [Yandex Direct API 5 manual](https://tech.yandex.ru/direct/doc/dg/concepts/about-docpage/)
* [Yandex Direct API 4 and 4 Live manual](https://tech.yandex.ru/direct/doc/dg-v4/concepts/About-docpage/)
* [Yandex OAuth API manual](https://tech.yandex.ru/oauth/)
* [Rails Authentication with OAuth 2.0 and OmniAuth](https://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rikkimongoose/ya-api-direct. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).