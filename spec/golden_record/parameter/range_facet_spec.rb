require "spec_helper"

describe GoldenRecord::Parameter::RangeFacet do
  describe "#build" do
    subject(:range_facet) do
      described_class.new(field, range: range, gap: gap, mincount: mincount).build
    end

    let(:field) do
      "id"
    end

    let(:range) do
      1..100
    end

    let(:gap) do
      10
    end

    let(:mincount) do
      1
    end

    it "returns parameter for paginator" do
      expect(range_facet[:facet]).to eq("true")
      expect(range_facet[:"facet.range"]).to eq("id")
      expect(range_facet[:"f.id.facet.range.start"]).to eq(1)
      expect(range_facet[:"f.id.facet.range.end"]).to eq(100)
      expect(range_facet[:"f.id.facet.range.gap"]).to eq(10)
      expect(range_facet[:"f.id.facet.mincount"]).to eq(1)
    end

    context "when mincount is nil" do
      let(:mincount) do
        nil
      end

      it { expect(range_facet).not_to have_key(:"f.id.facet.range.mincount") }
    end
  end
end
