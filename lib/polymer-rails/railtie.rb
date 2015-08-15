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
        add_preprocessors(app)
      end

      private

      def add_preprocessors(app)
        app.assets.register_preprocessor 'text/html', Polymer::Rails::DirectiveProcessor
        if Polymer::Rails::LEGACY_SPROCKETS
          app.assets.register_mime_type "text/html", '.html'
          app.assets.register_postprocessor 'text/html', :web do |context, data|
            Polymer::Rails::ComponentsProcessor.new(context, data).process
          end
        else
          app.assets.register_mime_type 'text/html', extensions: ['.html']
          app.assets.register_bundle_processor 'text/html', ::Sprockets::Bundle
          app.assets.register_postprocessor 'text/html', Polymer::Rails::ComponentsProcessor
        end
      end
    end
  end
end
