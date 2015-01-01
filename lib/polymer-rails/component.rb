require 'nokogumbo'

module Polymer
  module Rails
    class Component

      XML_NODES = ['*[selected]', '*[checked]', '*[src]:not(script)']

      def initialize(data)
        @doc = ::Nokogiri::HTML5("<body>#{data}</body>")
      end

      def create_node(name, content)
        node = ::Nokogiri::XML::Node.new(name, @doc)
        node.content = content
        node
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

      def to_html
        @doc.css("body").inner_html
      end

      def xml_nodes
        @doc.css(XML_NODES.join(','))
      end

      def stringify
        xml_nodes.reduce(to_html) do |output, node|
          output.gsub(node.to_html, node.to_xml)
        end
      end

    private

      def is_external?(source)
        !URI(source).host.nil?
      end
    end
  end
end
