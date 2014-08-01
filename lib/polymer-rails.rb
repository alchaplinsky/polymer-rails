require "polymer-rails/version"
require "polymer-rails/processors/directive_processor"
require "polymer-rails/processors/assets_processor"
require "polymer-rails/helpers/asset_tag_helper"
require "polymer-rails/engine" if defined?(::Rails)
require "polymer-rails/railtie" if defined?(::Rails)
