require "golden_record/value/base"
require "golden_record/parameter/base"

module GoldenRecord
  module Value
    class Sort
      DIRECTIONS = {
        asc: "asc",
        ascending: "asc",
        desc: "desc",
        descending:"desc",
      }.freeze

      def initialize(name, direction = nil)
        @name = name
        @direction = (direction || :asc).to_sym
      end

      def build
        "#{@name} #{direction}"
      end

      private

      def direction
        DIRECTIONS[@direction] or raise ArgumentError.new("Invalid sort type")
      end
    end
  end
end
