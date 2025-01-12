# Monerorequest

ruby gem for encoding and decoding [Monero Payment Request Standard](https://github.com/lukeprofits/Monero_Payment_Request_Standard?tab=readme-ov-file#introduction) requests.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add monerorequest

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install monerorequest

## Usage


### V1
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
enc = Monerorequest::Encoder.new(req, 1)
```

Decode a request:
```ruby
require 'monerorequest'

req = "monero-request:1:H4sIAAAAAAACAy2QS4vUQBSF/0qondA9XanqJJ3sZjEozGYW4kooKpWbTjmVqnQ9pjuKID7HlStxZiEo4pMBQRAcFPwvCq5c2O0fMD24utxzOR/n3FuItyZoj4o0iWm+k8YjJBqu58CkrqTg3lgWrEIFarzvisnEGlOOG5AVaAtSNDuw4m2nYCJsuIkGd7AWtOgHx8GVgwvBedMyxUvYYtafHrz49fT13+8nb+rNnS/nm7ff3v04vb+/fvj8w/WAcQw/3z++dDnai67tbp4cP4ouRP7787M/Z69eJtF+tNycnd/bW9/9+NUN+Ir3jnVgWSmVknrORC8UoCKnI6RDWw4XU7OO9y1o71BB8hH6vzFZDYFIlRFe1yTPeVblpB6YDpQC69iSD3P4DZruUtybtGxXcqZS08yrlMeYmMNF1lF+o1FULvzMxwL3C3DikAM/8jSmSpbG9NbWqll1mQtJ6jgJJqFHIe+obDQsLU22NZzn1rOKe9hGwmQ6xskYp1fjWTElBaFjnBUYo9v/ANjVPGWxAQAA"
dec = Monerorequest::Decoder.new(req)
dec.decode
```

### V2
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
  "schedule" => '* * 1 * *',
  "number_of_payments" => 12,
  "change_indicator_url" => "[some url here]"
}
enc = Monerorequest::Encoder.new(req, 2)
```

Decode a request:
```ruby
require 'monerorequest'

req = "monero-request:2:H4sIAAAAAAACAy2PTW/CMAyG/wrKEVFIE9rS3nbbkcPukZu4JCNNSj6Abtp/X5h2sCw/9vva/iYw++wSGdqm5v2+rXdEanAXFMYpIyH5IHKwZCA6pWU4HIL3Y6XRKHQBjdR7fMK8WDzIkL9IUecQ0Mm1KM7v5z8Qk5+FhRFfNgljKtTlecQg/CQWWGd0KZKB9TvyXwmjyixTHYNpYn0PnerZVHRRalTZYuluN9tNXWL7wmgthigeUHL5hhzfOF19O85Pc7Kt1xfVQk2Zv966hcOnttzc0inVkq43jPIKCPfEa27N6P0awmT1c+libtoILPuG33O/cKMdPgJv4mtlgpCEgvS6hVF2rGhT0fajPg1HNjBe0W6glPz8AihAH5JjAQAA"
dec = Monerorequest::Decoder.new(req)
dec.decode
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Adding a new Monerorequest version

Adding a new Monerorequest version should be simple.

1. Update SUPPORTED_MR_VERSIONS in ```lib/monerorequest.rb```.
2. Add any necessary pipelines and validators in their respective folders.
3. Define a file named "vX.rb" where X is your version that pulls in the pipelines and validators it needs.
4. Make sure you add spec coverage for any new code you write and run ```bundle exec rubocop``` to ensure it passes the linter.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/snex/monerorequest.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
