# OmniAuth Cognito OAuth2 Strategy

OmniAuth Strategy to authenticate with Cognito via OAuth2 using authorization code grant.

## Installation
Install the gem and add to the application's Gemfile by executing:

```shell
bundle add omniauth-cognito
```

If bundler is not being used to manage dependencies, install the gem by executing:
```shell
gem install omniauth-cognito
```

## Usage

### Devise
Add the following to `config/initializers/devise.rb`:

```ruby
config.omniauth :cognito,
  ENV['COGNITO_CLIENT_ID'],
  ENV['COGNITO_CLIENT_SECRET'],
  scope: 'openid email profile phone aws.cognito.signin.user.admin',
  client_options: {
    site: ENV['COGNITO_DOMAIN']
  }
```

### OmniAuth
Add the following to `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cognito,
    ENV['COGNITO_CLIENT_ID'],
    ENV['COGNITO_CLIENT_SECRET'],
    scope: 'openid email profile phone aws.cognito.signin.user.admin',
    client_options: {
      site: ENV['COGNITO_DOMAIN']
    }
end
```

Note: For app without client secret (e.g. SPA), use `nil` in place of `ENV['COGNITO_CLIENT_SECRET']`

Then add the following to `config/routes.rb` so the callback routes are defined.

```ruby
devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
```

Make sure your model is omniauthable. Generally this is `app/models/user.rb`

```ruby
devise :omniauthable, omniauth_providers: [:cognito]
```

### Auth Hash
Here's an example of auth hash you available in the callback, which can be accessed as `request.env['omniauth.auth']`:

```json
{
  "provider": "cognito",
  "uid": "1cb40fcd-756d-4388-beb3-ab241e8ede84",
  "info": {
    "name": "Dinesh Budhayer",
    "email": "budhayer96d@gmail.com",
    "first_name": "Dinesh",
    "last_name": "Budhayer",
    "preferred_username": null,
    "phone_number": null,
    "phone_number_verified": null,
    "email_verified": "true"
  },
  "credentials": {
    "token": "ACCESS_TOKEN",
    "refresh_token": "REFRESH_TOKEN",
    "expires_at": 1700586000,
    "expires": true
  },
  "extra": {}
}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ayerdines/omniauth-cognito. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/omniauth-cognito/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Omniauth::Cognito project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/omniauth-cognito/blob/main/CODE_OF_CONDUCT.md).
