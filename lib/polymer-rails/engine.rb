module Polymer
  module Rails
    class Engine < ::Rails::Engine
      config.assets.precompile += %w( polymer/polymer.js )
      ActionView::Helpers::AssetTagHelper.module_eval do
        include AssetTagHelper
      end
    end
  end
end
