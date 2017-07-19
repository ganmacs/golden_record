require "golden_record/parameters/restriction/base"

module GoldenRecord
  module Parameters
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
