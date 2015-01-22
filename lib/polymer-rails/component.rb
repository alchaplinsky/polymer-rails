require 'nokogumbo'

module Polymer
  module Rails
    class Component

      ENCODING = 'UTF-8'
      XML_NODES = ['*[selected]', '*[checked]', '*[src]:not(script)']
      XML_OPTIONS = { save_with: Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS }

      def initialize(data)
        @doc = ::Nokogiri::HTML5("<body>#{data}</body>")
      end

      def stringify
        xml_nodes.reduce(to_html) do |output, node|
          output.gsub(node.to_html, node.to_xml(XML_OPTIONS)).encode(ENCODING)
        end
      end

      def replace_node(node, name, content)
        node.replace create_node(name, content)
      end

      def stylesheets
        @doc.css("link[rel='stylesheet']").reject{|tag| is_external? tag.attributes['href'].value}
      end

      def javascripts
        @doc.css("script[src]").reject{|tag| is_external? tag.attributes['src'].value}
      end

      def imports
        @doc.css("link[rel='import']")
      end

    private

      def create_node(name, content)
        node = ::Nokogiri::XML::Node.new(name, @doc)
        node.content = content
        node
      end

      def to_html
        @doc.css("body").children.to_html(encoding: ENCODING).lstrip
      end

      def xml_nodes
        @doc.css(XML_NODES.join(','))
      end

      def is_external?(source)
        !URI(source).host.nil?
      end
    end
  end
end
