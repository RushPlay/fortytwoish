# Beepsend

Simple gem that implements sending SMS using Beepsend API [api.beepsend.com/docs.html](http://api.beepsend.com/docs.html#send-sms)

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
  config.token = 'XXX' # you get this token after registering in Beepsend
end
```

## Usage

Here is example usage of this gem:

```ruby
Fortytwoish::Client.new('15415553010', 'hello, world!').send_message
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RushPlay/fortytwoiiish.

## License

GNU GPLv3
