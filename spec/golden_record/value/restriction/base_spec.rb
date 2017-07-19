require "spec_helper"

describe GoldenRecord::Value::Restriction::Base do
  describe "#build" do
    subject(:base_value) do
      described_class.new("id", value, negate).build
    end

    let(:value) do
      2
    end

    let(:negate) do
      false
    end

    context "when value is Time" do
      let(:value) do
        Time.utc(2000, 1, 1, 20, 15, 1)
      end

      it { expect(base_value).to eq("id:2000-01-01T20:15:01Z") }
    end

    context "when value includes solr escape string" do
      let(:value) do
        "foo*bar"
      end

      it { expect(base_value).to eq("id:foo\\*bar") }
    end

    context "when negate is true" do
      let(:negate) do
        true
      end

      it { expect(base_value).to eq("-id:2") }
    end
  end
end
