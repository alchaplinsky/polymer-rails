require 'nokogiri'

module Polymer
  module Rails
    class AssetsProcessor < Sprockets::Processor

      def evaluate(context, locals)
        @context = context
        @doc = Nokogiri::HTML::Document.parse(data)
        inline_styles
        inline_javascripts
        @doc.inner_html
      end

      def inline_javascripts
        @doc.css("script[src]").each do |src|
          script = Nokogiri::XML::Node.new('script', @doc)
          script.content = asset_content(src.attributes['src'].value)
          src.replace script
        end
      end

      def inline_styles
        @doc.css("link[rel='stylesheet']").each do |link|
          style = Nokogiri::XML::Node.new('style', @doc)
          style.content = asset_content(link.attributes['href'].value)
          link.replace style
        end
      end

      def asset_content(file)
        dir  = File.dirname(@context.pathname)
        path = File.absolute_path(file, dir)
        @context.evaluate path
      end

    end
  end
end
