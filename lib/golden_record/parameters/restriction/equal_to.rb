require "golden_record/parameters/restriction/base"

module GoldenRecord
  module Parameters
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
