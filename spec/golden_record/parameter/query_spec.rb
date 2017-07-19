require "spec_helper"

describe GoldenRecord::Parameter::Query do
  describe "#build" do
    subject(:field_list) do
      described_class.new(query).build
    end

    let(:query) do
      "id:3"
    end

    it { expect(field_list).to eq({ q: "id:3" }) }

    context "when query is GoldenRecord::Query::Base" do
      # TODO
    end
  end
end
