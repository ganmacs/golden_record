require "golden_record/value/restriction/base"

module GoldenRecord
  module Value
    module Restriction
      class LessThanEqual < Base
        private

        def solr_value
          "[* TO #{super}]"
        end
      end
    end
  end
end
