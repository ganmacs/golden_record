require "golden_record/query/restriction/base"

module GoldenRecord
  module Query
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
