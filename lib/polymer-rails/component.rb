module Polymer
  module Rails
    class Component

      def initialize(data)
        @doc = Hpricot(data)
      end

      def replace_node(node, name, content)
        # add the attributes that are not standard such as shim-shadowdom
        node.swap "<#{name}></#{name}>"
        node.inner_html content
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
