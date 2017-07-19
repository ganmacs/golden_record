require "golden_record/parameter/base"

module GoldenRecord
  module Parameter
    # http://lucene.apache.org/solr/guide/6_6/common-query-parameters.html#CommonQueryParameters-ThestartParameter
    # http://lucene.apache.org/solr/guide/6_6/common-query-parameters.html#CommonQueryParameters-TherowsParameter
    class Pagination
      DEFAULT_PAGE = 1
      DEFAULT_PER_PAGE = 10
      DEFAULT_OFFSET = 0

      attr_writer :page, :per_page

      def initialize(page: nil, per_page: nil, offset: nil)
        @page = page
        @per_page = per_page
        @offset = offset
      end

      def page=(v)
        @page = v.to_i if v
      end

      def build
        { start: start, rows: rows }
      end

      private

      def page
        if @page
          @page.to_i
        else
          DEFAULT_PAGE
        end
      end

      def per_page
        if @per_page
          @per_page.to_i
        else
          DEFAULT_PER_PAGE
        end
      end

      def offset
        if @offset
          @offset.to_i
        else
          DEFAULT_OFFSET
        end
      end

      def start
        (page - 1) * per_page + offset
      end

      def rows
        per_page
      end
    end
  end
end
