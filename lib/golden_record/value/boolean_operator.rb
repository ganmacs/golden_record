require "golden_record/value/restriction"
require "golden_record/value/base"

module GoldenRecord
  module Value
    class BooleanOperator < Base
      def initialize
        @components = []
        yield(self) if block_given?
      end

      def with(field, value = nil)
        add_restriction(field, value, false)
      end

      def add(v)
        @components << v
        v
      end

      def add_and
        comp = AND.new
        yield(comp) if block_given?
        @components << comp
        comp
      end

      def add_or
        comp = OR.new
        yield(comp) if block_given?
        @components << comp
        comp
      end

      def add_not(v)
        nop = NOT.new(v)
        @components << nop
        nop
      end

      def build
        case @components.size
        when 0
        # nothing
        when 1
          @components.first.build
        else
          v = @components.map(&:build).join(" #{operator} ")
          "(#{v})"
        end
      end

      def add_restriction(field, value = nil, negated = false)
        type_class =
          case value
          when Range then GoldenRecord::Value::Restriction::Between
          when Array then GoldenRecord::Value::Restriction::Any
          else GoldenRecord::Value::Restriction::EqualTo
          end
        type_class.new(field, value, negated).tap do |v|
          @components << v
        end
      end

      def operator
        raise NotImplementedError
      end
    end

    class AND < BooleanOperator
      private

      def operator
        "AND"
      end
    end

    class OR < BooleanOperator
      private

      def operator
        "OR"
      end
    end

    class NOT
      def initialize(cond)
        @cond = cond
      end

      def build
        "-#{cond.to_param}"
      end
    end
  end
end
