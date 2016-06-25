require 'nokogiri'
require 'nokogumbo'

module Polymer
  module Rails
    module XmlAdapters
      class Nokogiri < Base
        def parse_document data
          ::Nokogiri::HTML5 data
        end

        def create_node doc, name, content
          node = ::Nokogiri::XML::Node.new(name, doc)
          node.content = content
          node
        end

        def replace_node old_node, new_node
          old_node.replace new_node
        end

        def stringify doc
          doc.to_xhtml.gsub(/(&amp;)|(&lt;)|(&gt;)/, '&amp;' => '&', '&lt;' => '<', '&gt;' => '>')
        end

        def css_select doc, selector
          doc.css selector
        end
      end
    end
  end
end
