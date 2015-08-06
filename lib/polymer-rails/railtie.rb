module Polymer
  module Rails
    class Railtie < ::Rails::Railtie
      initializer :polymer_html_import do
        helpers = %q{ include AssetTagHelper }
        ::ActionView::Base.module_eval(helpers)
        ::Rails.application.assets.context_class.class_eval(helpers)
      end

      initializer :precompile_polymer do |app|
        if app.config.respond_to? (:assets)
          app.config.assets.precompile += %w( polymer/polymer.js )
        end
      end

      initializer :add_preprocessors do |app|
        if Polymer::Rails::LEGACY_SPROCKETS
          add_preprocessors_legacy(app)
        else
          add_preprocessors(app)
        end
      end

      private

      def add_preprocessors(app)
        app.assets.register_mime_type 'text/html', extensions: ['.html']
        app.assets.register_preprocessor 'text/html', Polymer::Rails::DirectiveProcessor
        app.assets.register_bundle_processor 'text/html', ::Sprockets::Bundle
        app.assets.register_postprocessor 'text/html', Polymer::Rails::ComponentsProcessorV3
      end

      def add_preprocessors_legacy(app)
        app.assets.register_mime_type "text/html", '.html'
        app.assets.register_preprocessor "text/html", Polymer::Rails::DirectiveProcessor
        app.assets.register_postprocessor 'text/html', :web do |context, data|
          Polymer::Rails::ComponentsProcessorV2.new(context, data).process
        end
      end

    end
  end
end
