require "golden_record/parameter_builder/common"

module GoldenRecord
  module ParameterBuilder
    class Standard < Common
      def initialize(opt = {})
        super
        @standard_params = GoldenRecord::Parameters::Standard.new
        @queries << @standard_params

        @facet_params = GoldenRecord::Parameters::Facet.new
        @queries << @facet_params
      end

      def query(q)
        @standard_params.query(q)
        self
      end

      def field_facet(field, opt = {})
        @facet_params.field_facet(field, opt)
        self
      end

      def range_facet(field, opt = {})
        @facet_params.field_facet(field, opt)
        self
      end
    end
  end
end
