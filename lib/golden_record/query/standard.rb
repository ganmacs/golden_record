require "golden_record/query/base"

module GoldenRecord
  module Query
    # http://lucene.apache.org/solr/guide/6_6/common-query-parameters.html
    class Standard < Base
      def initialize
        super
      end

      def query(q)
        @components << GoldenRecord::Parameter::Query.new(q)
      end
    end
  end
end
