require "golden_record/parameter/base"

module GoldenRecord
  module Parameter
    class Query < Base
      def initialize(q)
        @q = q
      end

      def build
        case @q
        when String
          { q: @q }
        when GoldenRecord::Query::Base
          { q: @q.to_param }
        else
          { q: @q.to_s }
        end
      end
    end
  end
end
