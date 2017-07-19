module GoldenRecord
  module Parameter
    class Base
      def build
        raise NotImplementedError
      end
    end
  end
end
