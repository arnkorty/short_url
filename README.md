# ShortUrl

a ruby short url generate lib base on redis

## Installation

Add this line to your application's Gemfile:

    gem 'short_url'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install short_url

## Usage
```ruby
require 'short_url'
ShortUrl.config do |config|
  # config redis db connect
  config.redis     = Redis.new
  # md5 token
  config.token_key = ''
  # generate short url type, md5 or random
  config.type      = 'md5'
end

ShortUrl.generate("https://google.com") # => yrbnPC
ShortUrl.get_url("yrbnPC")              # => https://google.com
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
