require "golden_record/parameters/base"

module GoldenRecord
  module Parameters
    # http://lucene.apache.org/solr/guide/6_6/faceting.html
    class Facet < Base
      def add_field_facet(field, opt)
        GoldenRecord::Parameter::FieldFacet.new(field, opt).tap do |v|
          # Override explicitly sice facet has parameter like f.<name>.<param_name>.
          @components.reject! { |e| e.is_a?(GoldenRecord::Parameter::FieldFacet) }
          @components << v
        end
      end

      def add_range_facet(field, range:, gap:, **opt)
        GoldenRecord::Parameter::RangeFacet.new(field, range: range, gap: gap, **opt).tap do |v|
          # Override explicitly sice facet has parameter like f.<name>.<param_name>.
          @components.reject! { |e| e.is_a?(GoldenRecord::Parameter::RangeFacet) }
          @components << v
        end
      end
    end
  end
end
