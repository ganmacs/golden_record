require "spec_helper"

describe GoldenRecord::Parameter::FieldList do
  describe "#build" do
    subject(:field_list) do
      described_class.new(["id", "name", "recipe"]).build
    end

    it { expect(field_list).to eq({ fl: "id,name,recipe" }) }
  end
end
