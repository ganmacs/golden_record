require "spec_helper"

describe GoldenRecord::Value::Restriction::Any do
  describe "#build" do
    subject(:any_value) do
      described_class.new("id", value, false).build
    end

    let(:value) do
      [1, 3, 3]
    end

    it { expect(any_value).to eq("id:(1 OR 3 OR 3)") }

    context "with empty value" do
      let(:value) do
        []
      end

      it { expect(any_value).to eq("id:[* TO *]") }
    end
  end
end
