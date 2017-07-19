require "golden_record/value/restriction/base"

module GoldenRecord
  module Value
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
