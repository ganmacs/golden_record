require "spec_helper"

describe GoldenRecord::Parameters::Standard do
  let(:standard_query) do
    described_class.new
  end

  describe "#build" do
    context "when calling add_query" do
      before do
        standard_query.add_query("id:3")
      end

      it "builds parameter" do
        param = standard_query.build
        expect(param).to eq({ q: "id:3" })
      end
    end
  end

  describe "#add_query" do
    it "return a parameter class instance" do
      v = standard_query.add_query("id:3")
      expect(v).to be_a(GoldenRecord::Parameter::Query)
    end
  end
end
