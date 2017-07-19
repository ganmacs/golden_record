require "spec_helper"

describe GoldenRecord::Value::Restriction::LessThanEqual do
  describe "#build" do
    subject(:less_than_equal_value) do
      described_class.new("id", value, false).build
    end

    let(:value) do
      2
    end

    it { expect(less_than_equal_value).to eq("id:[* TO 2]") }
  end
end
