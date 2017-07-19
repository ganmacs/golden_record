require "golden_record/parameters/restriction/base"

module GoldenRecord
  module Parameters
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
