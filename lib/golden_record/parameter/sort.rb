require "golden_record/parameter/base"

module GoldenRecord
  module Parameter
    class Sort
      def initialize
        @sorts = []
      end

      # @param other [GoldenRecord::Value::Sort]
      def <<(other)
        @sorts << other
      end

      def build
        if @sorts.empty?
          {}
        else
          { sort: @sorts.map(&:build).join(",") }
        end
      end
    end
  end
end
