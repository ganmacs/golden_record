require "spec_helper"

describe GoldenRecord::Value::Restriction::Between do
  describe "#build" do
    subject(:between_value) do
      described_class.new("id", 1..2, false).build
    end

    it { expect(between_value).to eq("id:[1 TO 2]") }
  end
end
