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
          file = component_path(import.attributes['href'].value)
          unless file.nil?
            @context.require_asset file
            import.remove
          else
            log "Unable to find file: #{import.attributes['href'].value}"
          end
        end
      end

      def inline_javascripts
        @component.javascripts.each do |script|
          file = asset_content(script.attributes['src'].value)
          unless file.nil?
            @component.replace_node(script, 'script', file)
          else
            log "Unable to find file: #{script.attributes['src']}"
          end
        end
      end

      def inline_styles
        @component.stylesheets.each do |link|
          file = asset_content(link.attributes['href'].value)
          unless file.nil?
            @component.replace_node(link, 'style', file)
          else
            log "Unable to find file #{link.attributes['href'].value}"
          end
        end
      end

      def asset_content(file)
        dir  = File.dirname(@context.pathname)
        path = File.absolute_path(file, dir)
        if File.exists? path
          @context.evaluate path
        else
          nil
        end
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
      
      def log message
        str = "I, [#{Time.now.to_s}] INFO -- : #{message}"
        ::Rails.logger.debug str
        puts str
      end

    end
  end
end
