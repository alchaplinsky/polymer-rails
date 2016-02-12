module Polymer
  module Rails
    class Railtie < ::Rails::Railtie

      initializer :polymer_html_import do
        ::ActionView::Base.module_eval('include AssetTagHelper')
      end

      initializer :precompile_polymer do |app|
        if app.config.respond_to?(:assets)
          app.config.assets.precompile += %w( polymer/polymer.js )
        end
      end

      initializer :add_preprocessors do |app|
        add_preprocessors(app)
      end

      private

      def add_preprocessors(app)
        app.config.assets.configure do |env|
          env.context_class.class_eval("include Polymer::Rails::AssetTagHelper")
          env.register_preprocessor 'text/html', Polymer::Rails::Processors::Directive
          env.register_mime_type 'text/html', extensions: ['.html']
          env.register_bundle_processor 'text/html', ::Sprockets::Bundle
          env.register_postprocessor 'text/html', Polymer::Rails::Processors::Component
        end
      end
    end
  end
end
