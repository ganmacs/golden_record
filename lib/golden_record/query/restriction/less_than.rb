require "golden_record/query/restriction/base"

module GoldenRecord
  module Query
    module Restriction
      class LessThan < Base
        private

        def solr_value
          "{* TO #{super}}"
        end
      end
    end
  end
end
