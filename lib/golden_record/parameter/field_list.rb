require "golden_record/parameter/base"

module GoldenRecord
  module Parameter
    # http://lucene.apache.org/solr/guide/6_6/common-query-parameters.html#CommonQueryParameters-Thefl_FieldList_Parameter
    class FieldList < Base
      def initialize(list)
        @list = list
      end

      def build
        if @list.empty?
          { fl: "*" }
        else
          { fl: @list.join(",") }
        end
      end
    end
  end
end
