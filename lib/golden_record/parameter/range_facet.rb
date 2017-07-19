require "golden_record/parameter/facet_base"

module GoldenRecord
  module Parameter
    # http://lucene.apache.org/solr/guide/6_6/faceting.html#Faceting-RangeFaceting
    # @param :range [Range]
    class RangeFacet < FacetBase
      def initialize(field, range:, gap:, mincount: nil)
        @field = field
        @range = range
        @gap = gap
        @mincount = mincount
      end

      def build
        param = super
        param[:"facet.range"] = @field
        param[facet_param_name("range.start")] = @range.first
        param[facet_param_name("range.end")] = @range.last
        param[facet_param_name("range.gap")] = @gap
        param[facet_param_name("mincount")] = @mincount if @mincount
        param
      end
    end
  end
end
