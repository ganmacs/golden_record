require "golden_record/parameter/facet_base"

module GoldenRecord
  module Parameter
    # http://lucene.apache.org/solr/guide/6_6/faceting.html#Faceting-Field-ValueFacetingParameters
    # TODO:
    #   facet.prefix
    #   facet.contains
    #   facet.contains.ignoreCase
    #   facet.missing
    #   facet.method
    #   facet.exists
    #   facet.excludeTerms
    #   facet.enum.cache.minDf
    #   facet.overrequest.count
    #   facet.overrequest.ratio
    #   facet.threads

    class FieldFacet < FacetBase
      SORT_TYPE = ["count", "index"]

      def initialize(field, sort: nil, mincount: nil, limit: nil, offset: nil)
        @field = field
        @sort = sort
        @mincount = mincount
        @limit = limit
        @offset = offset
      end

      def build
        param = super.merge(:"facet.field" => @field)

        if @sort
          if SORT_TYPE.include?(@sort.to_s)
            param[facet_param_name("sort")] = @sort.to_s
          else
            raise(ArgumentError, "sort type should be #{SORT_TYPE.join(' or ')}.")
          end
        end

        if @limit
          param[facet_param_name("limit")] = @limit.to_i
        end

        if @offset
          param[facet_param_name("offset")] = @offset.to_i
        end

        if @mincount
          param[facet_param_name("mincount")] = @mincount.to_i
        end

        param
      end
    end
  end
end
