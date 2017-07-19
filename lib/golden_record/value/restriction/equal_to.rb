require "golden_record/value/restriction/base"

module GoldenRecord
  module Value
    module Restriction
      class EqualTo < Base
        private

        def solr_value
          if @value.nil?
            "[* TO *]"
          else
            super
          end
        end
      end
    end
  end
end
