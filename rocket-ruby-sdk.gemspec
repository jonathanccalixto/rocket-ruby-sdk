# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rocket/ruby/sdk/version'

Gem::Specification.new do |spec|
  spec.name          = "rocket-ruby-sdk"
  spec.version       = Rocket::Ruby::Sdk::VERSION
  spec.authors       = ["Jonathan C. Calixto"]
  spec.email         = ["jonathanccalixto@gmail.com"]

  spec.summary       = %q{SDK to Rocket Systems API and Simple Checkout http://www.rocketpays.com.}
  spec.description   = %q{Rocket Ruby SDK to Rocket API, with this SDK you can create invoices and retrieve invoice status from out Simple Checkout System, you can make API calls when your plan have it.}
  spec.homepage      = "https://github.com/jonathanccalixto/rocket-ruby-sdk"
  spec.license       = 'GNU GPL V3'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version     = ">= 1.9.3"
  spec.required_rubygems_version = ">= 1.3.6"

  spec.add_dependency "httparty"
  spec.add_dependency "activesupport"
  spec.add_dependency "recursive-open-struct"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-doc", "~> 0.8"
  spec.add_development_dependency "rspec", "~> 3.4"
end
