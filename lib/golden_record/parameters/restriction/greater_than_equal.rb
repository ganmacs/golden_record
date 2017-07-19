require "golden_record/parameters/restriction/base"

module GoldenRecord
  module Parameters
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
