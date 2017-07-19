require "rsolr"

module GoldenRecord
  module Query
    module Restriction
      class Base
        RESERVED_WORDS = Set["AND", "OR", "NOT"]
        # http://lucene.apache.org/solr/guide/6_6/the-standard-query-parser.html#TheStandardQueryParser-SpecifyingDatesandTimes
        SOLR_TIME_FORMAT = "%Y-%m-%dT%H:%M:%SZ"

        def initialize(field, value, negated)
          @field = field
          @value = value
          @negated = negated
        end

        def to_param
          if @negated
            generate_with_negative
          else
            generate_with_positive
          end
        end

        private

        def generate_with_positive
          "#{@field}:#{solr_value}"
        end

        def generate_with_negative
          "-#{generate_with_positive}"
        end

        def solr_value(value = @value)
          case value
          when Time, Date
            value.strftime(SOLR_TIME_FORMAT)
          when String
            solr_value = RSolr.solr_escape(value)
            if RESERVED_WORDS.include?(solr_value)
              %Q("#{solr_value}")
            else
              solr_value
            end
          else
            value.to_s
          end
        end
      end
    end
  end
end
