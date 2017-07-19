require "spec_helper"

describe GoldenRecord::Parameter::FieldFacet do
  describe "#build" do
    subject(:field_facet) do
      described_class.new("name", options).build
    end

    let(:options) do
      {}
    end

    it "reutrn parameters for field_facet" do
      expect(field_facet[:"facet.field"]).to eq("name")
      expect(field_facet[:facet]).to eq("true")
    end

    context "with sort" do
      let(:options) do
        { sort: :count }
      end

      it { expect(field_facet[:"f.name.facet.sort"]).to eq("count") }

      context "and sort's value is invalid" do
        let(:options) do
          { sort: :invalid }
        end

        it "raises an error" do
          expect { field_facet }.to raise_error(ArgumentError)
        end
      end

      context "with limit" do
        let(:options) do
          { limit: 10 }
        end

        it { expect(field_facet[:"f.name.facet.limit"]).to eq(10) }
      end

      context "with offset" do
        let(:options) do
          { offset: 1 }
        end

        it { expect(field_facet[:"f.name.facet.offset"]).to eq(1) }
      end

      context "with mincount" do
        let(:options) do
          { mincount: 3 }
        end

        it { expect(field_facet[:"f.name.facet.mincount"]).to eq(3) }
      end
    end
  end
end
