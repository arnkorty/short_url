# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'short_url/version'

Gem::Specification.new do |spec|
  spec.name          = "short_url"
  spec.version       = ShortUrl::VERSION
  spec.authors       = ["Arnkorty Fu"]
  spec.email         = ["arnkorty.fu@gmail.com"]
  spec.description   = %q{a ruby short url generate lib base on redis}
  spec.summary       = %q{ruby and redis short url generate lib base on redis}
  spec.homepage      = "https://github.com/arnkorty/short_url"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_dependency  "redis"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
