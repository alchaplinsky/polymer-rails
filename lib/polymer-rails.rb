module Polymer
  module Rails
    LEGACY_SPROCKETS = Gem::Version.new(Sprockets::VERSION) < Gem::Version.new('3.0.0')
  end
end

require "sprockets"
require "polymer-rails/version"
require "polymer-rails/processors/directive_processor"
if Polymer::Rails::LEGACY_SPROCKETS
  require "polymer-rails/processors/components_processor_v2"
else
  require "polymer-rails/processors/components_processor_v3"
end
require "polymer-rails/helpers/asset_tag_helper"
require "polymer-rails/engine" if defined?(::Rails)
require "polymer-rails/railtie" if defined?(::Rails)
