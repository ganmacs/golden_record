require "golden_record/query/base"

module GoldenRecord
  module Query
    # http://lucene.apache.org/solr/guide/6_6/common-query-parameters.html
    class Common < Base
      def initialize
        super
        @sort = GoldenRecord::Parameter::Sort.new
        @components << @sort
      end

      def field_list(*list)
        @components << GoldenRecord::Parameter::FieldList.new(list)
      end

      def sort_by(name, direction = nil)
        @sort << GoldenRecord::Value::Sort.new(name, direction)
        self
      end

      def pagination(page: nil, per_page: nil, offset: nil)
        if @pagination
          @pagination.page = page
          @pagination.per_page = per_page
          @pagination.offset = offset
        else
          @pagination = GoldenRecord::Parameter::Pagination.new(page, per_page, offset)
          @components << @pagination
        end
        self
      end
    end
  end
end
