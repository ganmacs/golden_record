require "golden_record/parameter"

module GoldenRecord
  module Query
    class Base
      def initialize
        @components = []
      end

      def to_param
        parameters = {}
        @components.each do |e|
          parameters.merge!(e.build)
        end
        parameters
      end
    end
  end
end
