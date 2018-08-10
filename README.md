# Fortytwoish

Simple gem that implements sending SMS using Fortytwo API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fortytwoish'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fortytwoish

## Configuaration

You can configurate by adding this code to Rails initializer for example:

```ruby
Fortytwoish.configure do |config|
  config.token = 'XXX'
  config.encoding = 'GSM7' # GSM7, UCS2, BINARY are available, GSM7 is default
end
```

## Usage

Here is example usage of this gem:

```ruby
client = Fortytwoish::Client.new('15415553010', 'hello, world!')
unless client.send == '200' # send returns '200' in case of success
  puts client.response_body # response_body contains detail about failed sending
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RushPlay/fortytwoish.

## License

MIT
