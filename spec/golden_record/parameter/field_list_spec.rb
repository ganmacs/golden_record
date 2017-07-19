require "spec_helper"

describe GoldenRecord::Parameter::FieldList do
  describe "#build" do
    subject(:field_list) do
      described_class.new(list).build
    end

    let(:list) do
      ["id", "name", "recipe"]
    end

    it { expect(field_list).to eq({ fl: "id,name,recipe" }) }

    context "with empty array" do
      let(:list) do
        []
      end

      it "sets *" do
        expect(field_list).to eq({ fl: "*" })
      end
    end
  end
end
