require "golden_record/value/restriction/base"

module GoldenRecord
  module Value
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
