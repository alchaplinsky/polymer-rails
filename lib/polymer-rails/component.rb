module Polymer
  module Rails
    class Component

      def initialize(data)
        @doc = ::Nokogiri::HTML.fragment(data)
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
        @doc.css("link[rel='stylesheet']")
      end

      def javascripts
        @doc.css("script[src]")
      end

      def imports
        @doc.css("link[rel='import']")
      end

      def stringify
        @doc.inner_html
      end

    end
  end
end
