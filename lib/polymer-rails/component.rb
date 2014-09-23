module Polymer
  module Rails
    class Component

      def initialize(data)
        @doc = Hpricot(data)
      end

      def replace_node(node, name, content)
        shim = ''
        shim = ' shim-shadowdom' if node.has_attribute? 'shim-shadowdom'
        node.swap "<#{name}#{shim}>\n#{content}\n</#{name}>"
        node
      end

      def stylesheets
        links = @doc.search("link")
        links.select do |link| link.attributes["rel"].downcase == "stylesheet" end
      end

      def javascripts
        scripts = @doc.search("script")
        scripts.select do |script| script.attributes["src"].empty? == false end
      end

      def imports
        links = @doc.search("link")
        links.select do |link| link.attributes["rel"].downcase == "import" end
      end

      def stringify
        @doc.inner_html
      end

    end
  end
end
