# TuneSpec

[![Gem Version](https://badge.fury.io/rb/tune_spec.svg)](https://badge.fury.io/rb/tune_spec)
[![Build Status](https://travis-ci.com/igor-starostenko/tune_spec.svg?branch=master)](https://travis-ci.com/igor-starostenko/tune_spec)
[![Maintainability](https://api.codeclimate.com/v1/badges/6d924fbd83bf675facf3/maintainability)](https://codeclimate.com/github/igor-starostenko/tune_spec/maintainability)

Provides an easy to use DSL for Page Object model. Helps to organize large scale integration tests by following Convention over Configuration paradigm.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tune_spec'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tune_spec

## Usage

To initialize framework folder structure run:

    $ tune --init

It creates a folder tree within your working directory:

```
lib
├── groups
├── pages
└── steps
```

Include the module in your framework:

```ruby
include TuneSpec
```

Then you can use TuneSpec DSL to store instances of your Groups, Steps and Page objects.
Assume that you have LoginPage object and LoginSteps and LoginGroups:
```ruby
pages(:login).fill_in 'Email', with: 'user@example.com'
pages(:login).fill_in 'Password', with: 'password'
pages(:login).login.click
```

Or in your LoginSteps you can describe steps as a a group of interactions and verifications on a page:
```ruby
steps(:login).visit_page
steps(:login).login_with_valid_credentials
steps(:login).verify_login
```

If you have steps class not associated with a particular page you may want to use dependency injection:
```ruby
steps(:header, page: :home).verify_menu
```
In this case it creates a `#header_steps` method that stores an instance of `HeaderSteps` and a `#home_page` method with an instance of `HomePage` as a page object of `HeaderSteps`. Next time you call this step it will return the same instance unless you change the page object associated with it.
Page initialization argument is set to `:page` by default. Can be changed with:
```ruby
TuneSpec.steps_page_arg = :page
```

You can go further and organize your steps within a group when details don't matter
```ruby
groups(:login).complete
```

The default instantiation of each of your objects is configurable:
```ruby
TuneSpec.configure do |config|
  config.page_opts = { env: ENV['TEST_ENV'] }
  config.steps_opts = { env: ENV['TEST_ENV'], page: :home }
  config.groups_opts = {}
end
```

### Calabash

In order to use the gem with calabash page instantiation features you need to set `TuneSpec.calabash_enabled = true`. Or configure the gem:
```ruby
TuneSpec.configure do |config|
  config.calabash_enabled = true
  config.calabash_wait_opts = { timeout: 10 } # set by default
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

To test documentation with [yard-doctest](https://github.com/p0deje/yard-doctest), run `bundle exec yard doctest`. For unit tests run `bundle exec rake test`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/igor-starostenko/tune_spec. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TuneSpec project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/tune_spec/blob/master/CODE_OF_CONDUCT.md).
