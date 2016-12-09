# PluggableAuthToken

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/pluggable_auth_token`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pluggable_auth_token'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pluggable_auth_token

Make sure Devise is installed

    $ rails generate devise:install
    $ rails generate devise User

## Usage

If you verify from another app, make sure the secret_key_base matches

```ruby 
class ApplicationController < ActionController::API

  require 'auth_token'

  protected

  def verify_jwt_token
    head :unauthorized if request.headers['HTTP_AUTHORIZATION'].blank? ||
        !AuthToken.new(token: request.headers['HTTP_AUTHORIZATION'].split('Token ').last).valid?
  end
end
```
in controllers that you want to protect

`   before_action :verify_jwt_token
`

### ToDo
to use the json endpoints for api validation
`  mount PluggableAuthToken::Engine, at: "/auth"  `

```bash
curl -H "Content-Type: application/json" -X POST -d '{"user":{"email":"test@example.com","password":"12345678","password_confirm":"12345678"}}' http://localhost:3000/users/signup
```

```bash
curl -H "Content-Type: application/json"       -X POST       -d '{"user": {"email":"test@example.com","password":"12345678"}}'       http://localhost:3000/auth/users/sign_in

```


```bash
curl -H "Authorization: Token [TOKEN]"  http://localhost:3000/my_controller --HEAD
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pluggable_auth_token. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

