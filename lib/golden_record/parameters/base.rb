require "golden_record/parameter"

module GoldenRecord
  module Parameters
    class Base
      def initialize
        @components = []
      end

      def build
        parameters = {}
        @components.each do |e|
          parameters.merge!(e.build)
        end
        parameters
      end
    end
  end
end
