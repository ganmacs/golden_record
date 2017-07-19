require "spec_helper"

describe GoldenRecord::ParameterBuilder::Standard do
  subject((:standard)) do
    described_class.new
  end

  describe "#build" do
    context "when calling query" do
      it "sets :q parameter" do
        v = standard.query("id:3").build
        expect(v[:q]).to eq("id:3")
      end

      context "calling query twice" do
        it "overrides first value" do
          v = standard
                .query("id:3")
                .query("id:2")
                .build

          expect(v[:q]).to eq("id:2")
        end
      end
    end

    context "when calling field_facet" do
      it "sets :facet.field and :facet parameter" do
        v = standard.field_facet("id").build
        expect(v).to eq({:"facet.field" => "id", facet: "true"})
      end

      context "calling field_facet twice" do
        it "overrides first value" do
          v = standard
                .field_facet("id")
                .field_facet("recipe")
                .build

          expect(v[:"facet.field"]).to eq("recipe")
          expect(v[:facet]).to eq("true")
        end
      end

      context "with sort option" do
        it "sets :sort parameter" do
          v = standard.field_facet("id", sort: :count).build

          expect(v[:"facet.field"]).to eq("id")
          expect(v[:facet]).to eq("true")
          expect(v[:"f.id.facet.sort"]).to eq("count")
        end
      end

      context "with limit option" do
        it "sets :limit parameter" do
          v = standard.field_facet("id", limit: 10).build

          expect(v[:"facet.field"]).to eq("id")
          expect(v[:facet]).to eq("true")
          expect(v[:"f.id.facet.limit"]).to eq(10)
        end
      end

      context "with mincount option" do
        it "sets :mincount parameter" do
          v = standard.field_facet("id", mincount: 10).build

          expect(v[:"facet.field"]).to eq("id")
          expect(v[:facet]).to eq("true")
          expect(v[:"f.id.facet.mincount"]).to eq(10)
        end
      end

      context "with offset option" do
        it "sets :offset parameter" do
          v = standard.field_facet("id", offset: 10).build

          expect(v[:"facet.field"]).to eq("id")
          expect(v[:facet]).to eq("true")
          expect(v[:"f.id.facet.offset"]).to eq(10)
        end
      end
    end

    context "when calling range_facet" do
      it "sets parameter for facet" do
        v = standard.range_facet("id", range: 1..10, gap: 1).build
        expect_hash = {
          facet: "true",
          :"facet.range" => "id",
          :"f.id.facet.range.start" => 1,
          :"f.id.facet.range.end" => 10,
          :"f.id.facet.range.gap" => 1,
        }

        expect(v).to eq(expect_hash)
      end

      context "calling range_facet twice" do
        it "sets parameter for facet" do
          v = standard
                .range_facet("id", range: 1..10, gap: 1)
                .range_facet("recipe", range: 10..20, gap: 2)
                .build

          expect(v[:facet]).to eq("true")
          expect(v[:"facet.range"]).to eq("recipe")
          expect(v[:"f.recipe.facet.range.start"]).to eq(10)
          expect(v[:"f.recipe.facet.range.end"]).to eq(20)
          expect(v[:"f.recipe.facet.range.gap"]).to eq(2)
        end
      end

      context "with mincount option" do
        it "sets parameter for facet" do
          v = standard
                .range_facet("id", range: 1..10, gap: 1, mincount: 1)
                .build

          expect(v[:facet]).to eq("true")
          expect(v[:"facet.range"]).to eq("id")
          expect(v[:"f.id.facet.range.start"]).to eq(1)
          expect(v[:"f.id.facet.range.end"]).to eq(10)
          expect(v[:"f.id.facet.range.gap"]).to eq(1)
          expect(v[:"f.id.facet.mincount"]).to eq(1)
        end
      end
    end
  end

  describe "#sorb_by" do
    it "returns myself" do
      expect(standard.sort_by("id", "asc")).to eq(standard)
    end

    context "when ommiting second argument" do
      it "returns myself" do
        expect(standard.sort_by("id")).to eq(standard)
      end
    end
  end

  describe "#field_facet" do
    it "returns myself" do
      expect(standard.field_facet("id")).to eq(standard)
    end
  end

  describe "#range_facet" do
    it "returns myself" do
      expect(standard.range_facet("id", range: 1..10, gap: 1)).to eq(standard)
    end
  end

  describe "#field_list" do
    it "returns myself" do
      expect(standard.field_list("id", "recipe")).to eq(standard)
    end
  end
end
