# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'polymer-rails/version'

Gem::Specification.new do |spec|
  spec.name          = "polymer-rails"
  spec.version       = Polymer::Rails::VERSION
  spec.authors       = ["Alex Chaplinsky"]
  spec.email         = ["alchaplinsky@gmail.com"]
  spec.summary       = %q{Use of web components with polymer with rails}
  spec.description   = %q{Use of web components and polymer-project in Ruby on Rails projects}
  spec.homepage      = "http://github.com/alchapone/polymer-rails"
  spec.license       = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]

  if RUBY_PLATFORM =~ /java/
    spec.platform = 'java'
    spec.add_runtime_dependency 'jar-dependencies', ">= 0.1.1"
    spec.requirements << "jar org.jsoup:jsoup, 1.8.3"
    spec.add_development_dependency 'ruby-maven', '>= 3.1.1.0'
  else
    spec.add_runtime_dependency "nokogiri", "~> 1.6"
    # lock nokogumbo to 1.4.2, looks like nokogumbo 1.4.3 deletes template tags from custom components
    spec.add_runtime_dependency "nokogumbo"
  end

  spec.add_runtime_dependency "rails",    ">= 3.1.0"
  spec.add_runtime_dependency "sprockets", "~> 3.0"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake",    "~> 0"
  spec.add_development_dependency "rspec",    "~> 3.0"
  spec.add_development_dependency "pry"
end
