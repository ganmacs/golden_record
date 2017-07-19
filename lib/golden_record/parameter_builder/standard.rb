require "golden_record/parameter_builder/common"

module GoldenRecord
  module ParameterBuilder
    class Standard < Common
      def initialize(opt = {})
        super
        @standard_query = GoldenRecord::Query::Standard.new
        @queries << @standard_query

        @facet_query = GoldenRecord::Query::Facet.new
        @queries << @facet_query
      end

      def query(q)
        @standard_query.query(q)
        self
      end

      def field_facet(field, opt = {})
        @facet_query.field_facet(field, opt)
        self
      end

      def range_facet(field, opt = {})
        @facet_query.field_facet(field, opt)
        self
      end
    end
  end
end
