require "golden_record/parameter/base"

module GoldenRecord
  module Parameter
    class Query < Base
      # http://lucene.apache.org/solr/guide/6_6/the-standard-query-parser.html#TheStandardQueryParser-StandardQueryParserParameters
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
