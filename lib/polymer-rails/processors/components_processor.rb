require 'nokogiri'
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
          @component.replace_node(script, 'script', asset_content(script.attributes['src'].value))
        end
      end

      def inline_styles
        @component.stylesheets.each do |link|
          @component.replace_node(link, 'style', asset_content(link.attributes['href'].value))
        end
      end

      def asset_content(file)
        dir  = File.dirname(@context.pathname)
        path = File.absolute_path(file, dir)
        @context.evaluate path
      end

      def component_path(file)
        dir = File.dirname(@context.pathname)
        dir.gsub!('/app/assets/', '/vendor/assets/') unless File.exist?(File.absolute_path(file, dir))
        File.absolute_path(file, dir)
      end

    end
  end
end
