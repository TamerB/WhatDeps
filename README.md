# WhatDeps

This is a Ruby gem that collects the project dependencies and operating system information, and displays the required system libraries to
install all your dependencies.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'WhatDeps', git: 'https://github.com/TamerB/WhatDeps.git'
```

And then execute:

    $ bundle install

## Usage

To start searching for your dependencies system requirements, execute:

    $ rake WhatDeps:show

Note: You can connect this gem to an other REST API clone from https://github.com/TamerB/GemService . Just add the proper base_uri in /lib/WhatDeps/what_deb_service.rb . For example:

```ruby
base_uri 'http://localhost:3000'
```  

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TamerB/WhatDeps. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).