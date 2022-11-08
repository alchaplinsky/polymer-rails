module Polymer
  module Rails
    module XmlAdapters
      class Base

        # HTML Encoding
        ENCODING = 'UTF-8'

        def self.factory
          klass = "#{module_parent}::#{RUBY_PLATFORM =~ /java/ ? 'Jsoup' : 'Nokogiri'}"
          klass.constantize.new
        end

      end
    end
  end
end

if RUBY_PLATFORM =~ /java/
  require "polymer-rails/xml_adapters/jsoup"
else
  require "polymer-rails/xml_adapters/nokogiri"
end
