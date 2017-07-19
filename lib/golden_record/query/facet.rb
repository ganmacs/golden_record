require "golden_record/query/base"

module GoldenRecord
  module Query
    # http://lucene.apache.org/solr/guide/6_6/faceting.html
    class Facet < Base
      def field_facet(field, opt)
        @components << GoldenRecord::Parameter::FieldFacet.new(field, opt)
      end

      def range_facet(field, opt)
        @components << GoldenRecord::Parameter::RangeFacet.new(field, opt)
      end
    end
  end
end
