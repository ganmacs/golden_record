require "golden_record/value/restriction/base"

module GoldenRecord
  module Value
    module Restriction
      class Between < Base
        private

        def solr_value
          "[#{@value.first} TO #{@value.last}]"
        end
      end
    end
  end
end
