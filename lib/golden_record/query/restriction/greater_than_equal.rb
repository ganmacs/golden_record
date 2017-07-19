require "golden_record/query/restriction/base"

module GoldenRecord
  module Query
    module Restriction
      class GreaterThanEqual < Base
        private

        def solr_value
          "[#{super} TO *]"
        end
      end
    end
  end
end
