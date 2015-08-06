require 'polymer-rails/component'
require 'polymer-rails/processors/components_processor'

module Polymer
  module Rails
    class ComponentsProcessorV2 < Sprockets::Processor
      include ::Polymer::Rails::ComponentsProcessor

      def initialize(context, data)
        @context = context
        @component = Component.new(data)
      end

    end
  end
end
