require "golden_record/parameters/base"

module GoldenRecord
  module Parameters
    # http://lucene.apache.org/solr/guide/6_6/common-query-parameters.html
    class Common < Base
      def initialize
        super
        @sort = GoldenRecord::Parameter::Sort.new
        @components << @sort
      end

      def add_field_list(*list)
        GoldenRecord::Parameter::FieldList.new(list).tap do |v|
          @components << v
        end
      end

      def add_sort_by(name, direction = nil)
        @sort << GoldenRecord::Value::Sort.new(name, direction)
        @sort
      end

      def add_pagination(page: nil, per_page: nil, offset: nil)
        if @pagination
          @pagination.page = page
          @pagination.per_page = per_page
          @pagination.offset = offset
        else
          @pagination = GoldenRecord::Parameter::Pagination.new(page: page, per_page: per_page, offset: offset)
          @components << @pagination
        end
        @pagination
      end
    end
  end
end
