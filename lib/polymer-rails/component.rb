require 'uri'

module Polymer
  module Rails
    class Component

      # Selectors for component resources
      SELECTORS = {
        html:       "link[rel='import']:not([type='css'])",
        stylesheet: "link[rel='stylesheet'], link[rel='import'][type='css']",
        javascript: "script[src]"
      }

      def initialize(data)
        @adapter = XmlAdapters::Base.factory
        @doc = @adapter.parse_document(data)
      end

      def stringify
        @adapter.stringify(@doc)
      end

      def replace_node(node, name, content)
        @adapter.replace_node node, @adapter.create_node(@doc, name, content)
      end

      def stylesheets
        @adapter.css_select(@doc, SELECTORS[:stylesheet]).reject{|tag| is_external? tag.attributes['href'].value}
      end

      def javascripts
        @adapter.css_select(@doc, SELECTORS[:javascript]).reject do |tag|
          is_external? tag.attributes['src'].value
        end
      end

      def html_imports
        @adapter.css_select(@doc, SELECTORS[:html])
      end

    private

      def is_external?(source)
        !URI(source).host.nil?
      end
    end
  end
end
