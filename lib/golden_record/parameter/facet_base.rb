require "golden_record/parameter/base"

module GoldenRecord
  module Parameter
    # http://lucene.apache.org/solr/guide/6_6/common-query-parameters.html#CommonQueryParameters-Thefl_FieldList_Parameter
    class FacetBase < Base
      def initialize(field, opt = {})
        @field = field
        @opt = opt
      end

      def build
        { facet: true }
      end

      private

      def facet_param_name(param)
        :"f.#{@field}.facet.#{param}"
      end
    end
  end
end
