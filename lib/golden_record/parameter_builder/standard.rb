require "golden_record/parameter_builder/common"

module GoldenRecord
  module ParameterBuilder
    # http://lucene.apache.org/solr/guide/6_6/common-query-parameters.html
    class Standard < Common
      def initialize(opt = {})
        super
        @standard_params = GoldenRecord::Parameters::Standard.new
        @queries << @standard_params

        @facet_params = GoldenRecord::Parameters::Facet.new
        @queries << @facet_params
      end

      def query(q)
        @standard_params.add_query(q)
        self
      end

      def field_facet(field, opt = {})
        @facet_params.add_field_facet(field, opt)
        self
      end

      def range_facet(field, range:, gap:, **opt)
        @facet_params.add_range_facet(field, range: range, gap: gap, **opt)
        self
      end
    end
  end
end
