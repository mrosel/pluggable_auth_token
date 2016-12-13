# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pluggable_auth_token/version'

Gem::Specification.new do |spec|
  spec.name          = "pluggable_auth_token"
  spec.version       = PluggableAuthToken::VERSION
  spec.authors       = ["Mac Rosel"]
  spec.email         = ["mac@bbtnetworks.com"]

  spec.summary       = %q{Simple plugin for creating and validating a JWT token }
  spec.homepage      = "https://bbtnetworks.com"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rails"

  spec.add_dependency "devise"
  spec.add_dependency "jwt"
  spec.add_dependency "rack-cors"


end
