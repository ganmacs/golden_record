require "golden_record/query/restriction"
require "golden_record/query/base"

module GoldenRecord
  module Query
    class BooleanOperator < Base
      def initialize
        super
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

      def to_param
        case @components.size
        when 0
        # nothing
        when 1
          @components.first.to_param
        else
          v = @components.map(&:to_param).join(" #{operator} ")
          "(#{v})"
        end
      end

      private

      def add_restriction(field, value = nil, negated = false)
        type_class =
          case value
          when Range then GoldenRecord::Query::Restriction::Between
          when Array then GoldenRecord::Query::Restriction::Any
          else GoldenRecord::Query::Restriction::EqaulTo
          end
        @components << type_class.new(field, value, negated)
      end

      def negate(v)
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

      def to_param
        "-#{cond.to_param}"
      end
    end
  end
end