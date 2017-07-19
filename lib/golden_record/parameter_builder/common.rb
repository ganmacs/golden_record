require "golden_record/parameter_builder/base"

module GoldenRecord
  module ParameterBuilder
    class Common < Base
      def initialize(opt = {})
        super
        @common_params = GoldenRecord::Parameters::Common.new
        @queries = [@common_params]
      end

      def sort_by(name, direction = nil)
        @common_params.add_sort_by(name, direction)
        self
      end

      def pagination(page: nil, per_page: nil, offset: nil)
        @common_params.add_pagination(page: page, per_page: per_page, offset: offset)
        self
      end

      def field_list(*list)
        @common_params.add_field_list(*list)
        self
      end
    end
  end
end
