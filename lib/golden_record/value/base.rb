require "golden_record/parameter/base"

module GoldenRecord
  module Value
    class Base
      def build
        raise NotImplementedError
      end
    end
  end
end
