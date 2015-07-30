require 'polymer-rails/component'
require 'polymer-rails/processors/components_processor'

module Polymer
  module Rails
    class ComponentsProcessorV3
      include ::Polymer::Rails::ComponentsProcessor

      def self.instance
        @instance ||= new
      end

      def self.call(input)
        instance.call(input)
      end

      def call(input)
        prepare(input)
        data = process

        @context.metadata.merge(data: data)
      end

      private

      def prepare(input)
        @context = input[:environment].context_class.new(input)
        @component = Component.new(input[:data])
      end

    end
  end
end
