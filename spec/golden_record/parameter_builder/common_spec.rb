require "spec_helper"

describe GoldenRecord::ParameterBuilder::Common do
  subject((:common)) do
    described_class.new
  end

  describe "#build" do
    context "when calling sort_by" do
      it "sets :sort parameter" do
        v = common.sort_by("id", "asc").build
        expect(v[:sort]).to eq("id asc")
      end

      context "calling sorb_by twice" do
        it "sets :sort parameter" do
          v = common
                .sort_by("id", "asc")
                .sort_by("recipe", "desc")
                .build

          expect(v[:sort]).to eq("id asc,recipe desc")
        end
      end

      context "when ommitng second argument" do
        it "sets default value asc" do
          v = common.sort_by("id").build
          expect(v[:sort]).to eq("id asc")
        end
      end
    end

    context "when calling pagination" do
      it "sets :start and :rows parameter" do
        v = common.pagination(page: 10, per_page: 10, offset: 0).build
        expect(v[:start]).to eq(90)
        expect(v[:rows]).to eq(10)
      end

      context "calling pagination twice" do
        it "overrides first value" do
          v = common
                .pagination(page: 10, per_page: 10, offset: 0)
                .pagination(page: 1, per_page: 20, offset: 0)
                .build

          expect(v[:start]).to eq(0)
          expect(v[:rows]).to eq(20)
        end
      end

      context "when ommitng arguments" do
        it "sets default value" do
          v = common.pagination.build
          expect(v[:start]).to eq(0)
          expect(v[:rows]).to eq(10)
        end
      end
    end

    context "when calling field_list" do
      it "sets :start and :rows parameter" do
        v = common.field_list("id", "recipe").build
        expect(v[:fl]).to eq("id,recipe")
      end

      context "calling pagination twice" do
        it "overrides first value" do
          v = common
                .field_list("id", "recipe")
                .field_list("user")
                .build

          expect(v[:fl]).to eq("user")
        end
      end
    end
  end

  describe "#sorb_by" do
    it "returns myself" do
      expect(common.sort_by("id", "asc")).to eq(common)
    end

    context "when ommiting second argument" do
      it "returns myself" do
        expect(common.sort_by("id")).to eq(common)
      end
    end
  end

  describe "#pagination" do
    it "returns myself" do
      expect(common.pagination(page: 1, per_page: 10, offset: 0)).to eq(common)
    end

    context "when ommiting arguments" do
      it "returns myself" do
        expect(common.pagination).to eq(common)
      end
    end
  end

  describe "#field_list" do
    it "returns myself" do
      expect(common.field_list("id", "recipe")).to eq(common)
    end
  end
end
