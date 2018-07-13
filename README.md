# Monthra

A month object that converts consistently into Date and Time objects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'monthra'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install monthra

## Usage

```
# Instantiate with a year and month
m = Monthra::Month.new(2018, 7)

# Convert to a date, time, or string
m.to_time
m.to_date
m.strfmonth("%Y-%m")

# Convert a date, time, or string into a month
Monthra::Month.at(Time.now)
Monthra::Month.at(Date.today)
Monthra::Month.strpmonth("2018-07", "%Y-%m")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jeremiahishere/monthra.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
