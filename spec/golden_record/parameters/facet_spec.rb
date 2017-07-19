require "spec_helper"

describe GoldenRecord::Parameters::Facet do
  let(:facet_params) do
    described_class.new
  end

  describe "#build" do
    context "when calling add_field_facet" do
      before do
        facet_params.add_field_facet("id", {})
      end

      it "return a class instance of added value" do
        param = facet_params.build
        expect(param[:"facet.field"]).to eq("id")
        expect(param[:facet]).to eq("true")
      end

      context "with option" do
        it "override first value" do
          facet_params.add_field_facet("id", sort: "count", mincount: 1, limit: 2, offset: 3)
          param = facet_params.build

          expect(param[:facet]).to eq("true")
          expect(param[:"facet.field"]).to eq("id")
          expect(param[:"f.id.facet.sort"]).to eq("count")
          expect(param[:"f.id.facet.mincount"]).to eq(1)
          expect(param[:"f.id.facet.limit"]).to eq(2)
          expect(param[:"f.id.facet.offset"]).to eq(3)
        end
      end

      context "when calling add_field_facet twice" do
        it "override first value" do
          facet_params.add_field_facet("id", sort: "count")
          facet_params.add_field_facet("recipe", sort: "index")
          param = facet_params.build

          expect(param[:facet]).to eq("true")
          expect(param[:"facet.field"]).to eq("recipe")
          expect(param[:"f.recipe.facet.sort"]).to eq("index")

          expect(param).not_to have_key("f.recipe.facet.sort")
        end
      end
    end

    context "when calling add_range_facet" do
      before do
        facet_params.add_range_facet("id", range: 1..10, gap: 1)
      end

      it "return a class instance of added value" do
        param = facet_params.build
        expect(param[:facet]).to eq("true")
        expect(param[:"facet.range"]).to eq("id")
        expect(param[:"f.id.facet.range.start"]).to eq(1)
        expect(param[:"f.id.facet.range.end"]).to eq(10)
        expect(param[:"f.id.facet.range.gap"]).to eq(1)
      end

      context "when calling add_range_facet twice" do
        it "override first value" do
          facet_params.add_range_facet("id", range: 1..10, gap: 1)
          facet_params.add_range_facet("recipe", range: 2..11, gap: 2)
          param = facet_params.build

          expect(param[:facet]).to eq("true")
          expect(param[:"facet.range"]).to eq("recipe")
          expect(param[:"f.recipe.facet.range.start"]).to eq(2)
          expect(param[:"f.recipe.facet.range.end"]).to eq(11)
          expect(param[:"f.recipe.facet.range.gap"]).to eq(2)

          expect(param).not_to have_key([:"f.id.facet.range.start"])
          expect(param).not_to have_key([:"f.id.facet.range.end"])
          expect(param).not_to have_key([:"f.id.facet.range.gap"])
        end
      end
    end
  end

  describe "#add_field_facet" do
    it "return a class instance of added value" do
      v = facet_params.add_field_facet("id", {})
      expect(v).to be_a(GoldenRecord::Parameter::FieldFacet)
    end
  end

  describe "#add_range_facet" do
    it "return a class instance of added value" do
      v = facet_params.add_range_facet("id", range: 1..10, gap: 1)
      expect(v).to be_a(GoldenRecord::Parameter::RangeFacet)
    end
  end
end
