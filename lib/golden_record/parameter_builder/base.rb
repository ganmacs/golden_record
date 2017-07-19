module GoldenRecord
  module ParameterBuilder
    class Base
      def initialize(opt = {})
        @opt = opt
        @queries = []
      end

      def build
        params = {}
        @queries.map(&:to_param).each do |e|
          params.merge!(e)
        end
        params
      end
    end
  end
end
