# SsmToEnv

This gem allows you to take parameters from AWS System Manager and puts them
in to your `ENV`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ssm_to_env'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ssm_to_env

## Usage

Simple use case:

```ruby
require 'ssm_to_env'

SsmToEnv.load!(
    '/foo/bar/baz' => 'FOO_BAR'
)
```

This will connect to SSM, get the parameter `/foo/bar/baz`, and save it to the `ENV['FOO_BAR']`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eLocal/ssm_to_env.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
