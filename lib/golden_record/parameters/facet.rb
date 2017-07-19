require "golden_record/parameters/base"

module GoldenRecord
  module Parameters
    # http://lucene.apache.org/solr/guide/6_6/faceting.html
    class Facet < Base
      def add_field_facet(field, opt)
        GoldenRecord::Parameter::FieldFacet.new(field, opt).tap do |v|
          @components << v
        end
      end

      def add_range_facet(field, range:, gap:, **opt)
        GoldenRecord::Parameter::RangeFacet.new(field, opt.merge(range: range, gap: gap)).tap do |v|
          @components << v
        end
      end
    end
  end
end
