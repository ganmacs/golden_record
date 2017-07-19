require "spec_helper"

describe GoldenRecord::Parameter::Sort do
  describe "#build" do
    subject(:sort) do
      described_class.new
    end

    before do
      sort << GoldenRecord::Value::Sort.new(name, direction)
    end

    let(:name) do
      "id"
    end

    let(:direction) do
      :asc
    end

    it "returns parameter for sort" do
      s = sort.build
      expect(s[:sort]).to eq("id asc")
    end

    context "with two sort condition" do
      before do
        sort << GoldenRecord::Value::Sort.new("price", "desc")
      end

      it "concats two sort conditions" do
        s = sort.build
        expect(s[:sort]).to eq("id asc,price desc")
      end
    end
  end
end
