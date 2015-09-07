module Polymer
  module Rails
    LEGACY_SPROCKETS = Gem::Version.new(Sprockets::VERSION) < Gem::Version.new('3.0.0')
  end
end

require "sprockets"
require "polymer-rails/version"
require "polymer-rails/xml_adapters/base"
require "polymer-rails/processors/directive"
require "polymer-rails/processors/component"
require "polymer-rails/helpers/asset_tag_helper"
require "polymer-rails/engine" if defined?(::Rails)
require "polymer-rails/railtie" if defined?(::Rails)
