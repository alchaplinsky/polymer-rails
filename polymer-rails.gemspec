# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'polymer-rails/version'

Gem::Specification.new do |spec|
  spec.name          = "polymer-rails"
  spec.version       = Polymer::Rails::VERSION
  spec.authors       = ["Alex Chaplinsky"]
  spec.email         = ["alchapone@yandex.ru"]
  spec.summary       = %q{Use of web components with polymer with rails}
  spec.description   = %q{Use of web components and polymer-project in Ruby on Rails projects}
  spec.homepage      = "http://github.com"
  spec.license       = "MIT"

  spec.files         = 'lib/polymer-rails.rb'

  spec.add_runtime_dependency "rails",       ">= 3.1.0"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake",    "~> 0"
end
