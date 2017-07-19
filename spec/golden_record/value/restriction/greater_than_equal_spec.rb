require "spec_helper"

describe GoldenRecord::Value::Restriction::GreaterThanEqual do
  describe "#build" do
    subject(:greater_than_equal_value) do
      described_class.new("id", value, false).build
    end

    let(:value) do
      2
    end

    it { expect(greater_than_equal_value).to eq("id:[2 TO *]") }
  end
end
