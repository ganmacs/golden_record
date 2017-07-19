require "spec_helper"

describe GoldenRecord::Value::Sort do
  describe "#build" do
    subject(:sort) do
      described_class.new(name, direction).build
    end

    let(:name) do
      "id"
    end

    let(:direction) do
      "asc"
    end

    it "return sort value" do
      expect(sort).to eq("id asc")
    end

    context "with invalid direction" do
      let(:direction) do
        "invalid"
      end

      it "raises error" do
        expect { sort }.to raise_error(ArgumentError)
      end
    end
  end
end
