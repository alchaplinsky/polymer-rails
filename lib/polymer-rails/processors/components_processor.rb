require 'polymer-rails/component'

module Polymer
  module Rails
    class ComponentsProcessor < Sprockets::Processor

      def initialize(context, data)
        @context = context
        @component = Component.new(data)
      end

      def process
        inline_styles
        inline_javascripts
        require_imports
        @component.stringify
      end

    private

      def require_imports
        @component.imports.each do |import|
          @context.require_asset component_path(import.attributes['href'].value)
          import.remove
        end
      end

      def inline_javascripts
        @component.javascripts.each do |script|
          begin
            @component.replace_node(script, 'script', asset_content(script.attributes['src'].value))
          rescue Sprockets::FileNotFound => e
            puts e.message
          end
        end
      end

      def inline_styles
        @component.stylesheets.each do |link|
          begin
            @component.replace_node(link, 'style', asset_content(link.attributes['href'].value))
          rescue Sprockets::FileNotFound => e
            puts e.message
          end
        end
      end

      def asset_content(file)
        dir  = File.dirname(@context.pathname)
        path = File.absolute_path(file, dir)
        @context.evaluate path
      end

      def component_path(file)
        search_file = file.sub(/^(\.\.\/)+/, '/').sub(/^\/*/, '')
        ::Rails.application.assets.paths.each do |path|
          file_list = Dir.glob( "#{File.absolute_path search_file, path }*")
          return file_list.first unless file_list.blank?
        end
        component = File.absolute_path file, File.dirname(@context.pathname)
        return File.exists?(component) ? component : nil
      end

    end
  end
end
