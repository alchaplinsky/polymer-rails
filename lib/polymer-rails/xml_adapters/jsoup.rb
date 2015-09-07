require 'ostruct'
require 'jar_dependencies'
require_jar 'org.jsoup', 'jsoup', '1.8.3' 

module Polymer
  module Rails
    module XmlAdapters
      class Jsoup < Base

        def parse_document data
          doc = org.jsoup.Jsoup.parse_body_fragment(data)
          doc.output_settings.charset(ENCODING)
          doc
        end

        def create_node doc, name, content
          node = doc.create_element(name)
          datanode = org.jsoup.nodes.DataNode.new(content, doc.base_uri)
          node.append_child datanode
          node
        end

        def stringify doc
          doc.select('body').html
        end

        def replace_node old_node, new_node
          old_node.replace_with new_node
        end

        def css_select doc, selector
          doc.select selector.gsub('\'', '')
        end
          
      end
    end
  end
end

Java::OrgJsoupNodes::Attributes.class_eval do
  def [] name
    OpenStruct.new value: get(name)
  end
end

Java::OrgJsoupNodes::Element.class_eval do
  alias name nodeName
end
