# Monerorequest

ruby gem for encoding and decoding [Monero Payment Request Standard](https://github.com/lukeprofits/Monero_Payment_Request_Standard?tab=readme-ov-file#introduction) requests.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add monerorequest

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install monerorequest

## Usage

Encode a request:
```ruby
require 'monerorequest'

req = {
  "custom_label" => "[some string here]",
  "sellers_wallet" => "[monero main address, starts with 4]",
  "currency" => "USD",
  "amount" => 420.69,
  "payment_id" => "[monero payment ID]",
  "start_date" => "[timestamp in rfc3339 format]",
  "days_per_billing_cycle" => 30,
  "number_of_payments" => 12,
  "change_indicator_url" => "[some url here]"
}
enc = Monerorequest::Encoder.new(req)
enc.encode(VERSION) # currently only version 1 is implemented
```

Decode a request:
```ruby
require 'monerorequest'

req = "monero-request:1:H4sIAAAAAAACAy2QS4vUQBSF/0qondA9XanqJJ3sZjEozGYW4kooKpWbTjmVqnQ9pjuKID7HlStxZiEo4pMBQRAcFPwvCq5c2O0fMD24utxzOR/n3FuItyZoj4o0iWm+k8YjJBqu58CkrqTg3lg
WrEIFarzvisnEGlOOG5AVaAtSNDuw4m2nYCJsuIkGd7AWtOgHx8GVgwvBedMyxUvYYtafHrz49fT13+8nb+rNnS/nm7ff3v04vb+/fvj8w/WAcQw/3z++dDnai67tbp4cP4ouRP7787M/Z69eJtF+tNycnd/bW9/9+NUN+Ir3jnVgWSmVknrORC8
UoCKnI6RDWw4XU7OO9y1o71BB8hH6vzFZDYFIlRFe1yTPeVblpB6YDpQC69iSD3P4DZruUtybtGxXcqZS08yrlMeYmMNF1lF+o1FULvzMxwL3C3DikAM/8jSmSpbG9NbWqll1mQtJ6jgJJqFHIe+obDQsLU22NZzn1rOKe9hGwmQ6xskYp1fjWTE
lBaFjnBUYo9v/ANjVPGWxAQAA"
dec = Monerorequest::Decoder.new(req)
dec.decode
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/snex/monerorequest.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
