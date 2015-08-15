module Polymer
  module Rails
    class SprocketsProcessor < Sprockets::Processor

      def initialize(context, data)
        @context = context
        @component = Component.new(data)
      end

    end
  end
end
