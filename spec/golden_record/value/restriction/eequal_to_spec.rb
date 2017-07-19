require "spec_helper"

describe GoldenRecord::Value::Restriction::EqualTo do
  describe "#build" do
    subject(:equal_to_value) do
      described_class.new("id", value, false).build
    end

    let(:value) do
      2
    end

    it { expect(equal_to_value).to eq("id:2") }

    context "when value is nil" do
      let(:value) do
        nil
      end

      it { expect(equal_to_value).to eq("id:[* TO *]") }
    end
  end
end
