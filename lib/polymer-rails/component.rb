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
        to_html(@doc.css('body').children).lstrip
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

      def to_html(child_nodes)
        child_nodes.map do |child_node|
          # can't just use to_html as libxml messes with attribute value encodings
          if child_node.text?
            child_node.text
          else
            name = child_node.name
            #attrs = child_node.attributes.map {|name,value| " #{name}=\"#{value}\""}.join
            attrs = child_node.attributes.map {|name,attr| " #{name}=#{attr.value.encode(:xml => :attr)}"}.join
            if child_node.children.empty? && child_node.description && child_node.description.save_end_tag?
              "<#{name}#{attrs}>"
            else
              "<#{name}#{attrs}>#{to_html(child_node.children)}</#{child_node.name}>"
            end
          end
        end.join
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
