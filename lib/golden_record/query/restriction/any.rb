require "golden_record/query/restriction/base"

module GoldenRecord
  module Query
    module Restriction
      class Any < Base
        private

        def solr_value
          if @value.empty?
            "[* TO *]"
          else
            val = @value.map { |v| super(v) }.join(" OR ")
            "(#{val})"
          end
        end
      end
    end
  end
end
