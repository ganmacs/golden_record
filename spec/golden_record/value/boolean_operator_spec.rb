require "spec_helper"

describe GoldenRecord::Value::BooleanOperator do
  let(:value_class) do
    Class.new(described_class) {
      def operator
        "AND"
      end
    }
  end

  let(:value) do
    value_class.new
  end

  describe ".new" do
    context "with block" do
      it "builds query" do
        ret = value_class.new { |q|
          q.with("id", 3)
          q.with("recipe", [1, 2, 3])
        }.build

        expect(ret).to eq("(id:3 AND recipe:(1 OR 2 OR 3))")
      end
    end
  end

  describe "#build" do
    context "when calling add_and" do
      it "bulds query including AND" do
        ret = value.add_and { |v|
          v.with("id", 3)
          v.with("name", "foo")
        }.build

        expect(ret).to eq("(id:3 AND name:foo)")
      end
    end

    context "when calling add_or" do
      it "bulds query including AND" do
        ret = value.add_or { |v|
          v.with("id", 3)
          v.with("name", "foo")
        }.build

        expect(ret).to eq("(id:3 OR name:foo)")
      end
    end

    context "with complex" do
      it "bulds query" do
        ret = value.add_or { |op|
          op.with("id", 3)
          op.with("name", "foo")

          op.add_and { |aop|
            aop.with("age", 1..10)
            aop.with("recipe_id", [1, 2, 3])
          }
        }.build

        expect(ret).to eq("(id:3 OR name:foo OR (age:[1 TO 10] AND recipe_id:(1 OR 2 OR 3)))")
      end
    end
  end

  describe "#add_and" do
    it "return a instance of AND class" do
      v = value.add_and
      expect(v).to be_a(GoldenRecord::Value::AND)
    end

    context "with block" do
      it "passes self object to block" do
        v = value.add_and do |_v|
          expect(_v).to be_a(GoldenRecord::Value::AND)
        end
        expect(v).to be_a(GoldenRecord::Value::AND)
      end
    end
  end

  describe "#add_or" do
    it "return a instance of OR class" do
      v = value.add_or
      expect(v).to be_a(GoldenRecord::Value::OR)
    end

    context "with block" do
      it "passes self object to block" do
        v = value.add_or do |_v|
          expect(_v).to be_a(GoldenRecord::Value::OR)
        end
        expect(v).to be_a(GoldenRecord::Value::OR)
      end
    end
  end

  describe "#add_not" do
    it "return a instance of NOT class" do
      v = value.add_not("id")
      expect(v).to be_a(GoldenRecord::Value::NOT)
    end
  end

  # #with
  describe "#add_restriction" do
    it "return a instance of Any class" do
      v = value.add_restriction("id", 1)
      expect(v).to be_a(GoldenRecord::Value::Restriction::EqualTo)
    end

    context "when restriction value is instance of Range class" do
      it "return a instance of Between class" do
        v = value.add_restriction("id", 1..2)
        expect(v).to be_a(GoldenRecord::Value::Restriction::Between)
      end
    end

    context "when restriction value is instance of Array class" do
      it "return a instance of Any class" do
        v = value.add_restriction("id", [1, 2, 3])
        expect(v).to be_a(GoldenRecord::Value::Restriction::Any)
      end
    end
  end
end
