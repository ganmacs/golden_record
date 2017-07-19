require "golden_record/query/restriction/base"

module GoldenRecord
  module Query
    module Restriction
      class EqaulTo < Base
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
