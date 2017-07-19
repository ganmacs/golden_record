require "golden_record/parameters/base"

module GoldenRecord
  module Parameters
    class Standard < Base
      def initialize
        super
      end

      def add_query(q)
        GoldenRecord::Parameter::Query.new(q).tap do |v|
          @components << v
        end
      end
    end
  end
end
