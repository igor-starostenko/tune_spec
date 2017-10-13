# TuneSpec
# #In Development#

Organizes large scale integration tests following Convention over Configuration paradigm.

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

In your framework include the module:

```ruby
include TuneSpec::Instances
```

Then you can use TuneSpec DSL to store instances of your Groups, Steps and Page objects.
Assume that you have LoginPage object and LoginSteps and LoginGroups

```ruby
page(:login).fill_in 'Email', with: 'user@example.com'
page(:login).fill_in 'Password', with: 'password'
page(:login).login.click
```

Or in your LoginSteps you can describe steps as a a group of interactions and verifications on a page:

```ruby
steps(:login).visit_page
steps(:login).login_with_valid_credentials
steps(:login).verify_login
```

You can go further and organize your steps within a group when details don't matter
```ruby
groups(:login).complete
```

The default instantiation of each of your objects is configurable:
```
TuneSpec.configure do |config|
  config.page_opts = { env: ENV['TEST_ENV'] }
  config.steps_opts = { env: ENV['TEST_ENV'], page: :home }
  config.groups_opts = {}
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tune_spec. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TuneSpec project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/tune_spec/blob/master/CODE_OF_CONDUCT.md).
