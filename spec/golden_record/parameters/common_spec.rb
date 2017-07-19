require "spec_helper"

describe GoldenRecord::Parameters::Common do
  let(:common_params) do
    described_class.new
  end

  describe "#build" do
    context "when calling add_field_list" do
      before do
        common_params.add_field_list(["id", "user"])
      end

      it "builds parameter" do
        param = common_params.build
        expect(param).to eq({ fl: "id,user" })
      end
    end

    context "when calling add_sort_by" do
      before do
        common_params.add_sort_by("id", "asc")
      end

      it "builds parameter" do
        param = common_params.build
        expect(param).to eq({ sort: "id asc" })
      end
    end

    context "when calling add_pagination" do
      before do
        common_params.add_pagination(page: 1, per_page: 10, offset: 0)
      end

      it "builds parameter" do
        param = common_params.build
        expect(param).to eq({ start: 0, rows: 10 })
      end
    end
  end

  describe "#add_field_list" do
    it "return a class instance of added value" do
      v = common_params.add_field_list(["id", "user"])
      expect(v).to be_a(GoldenRecord::Parameter::FieldList)
    end
  end

  describe "#add_sort_by" do
    it "return a class instance of added value" do
      v = common_params.add_sort_by("id", "asc")
      expect(v).to be_a(GoldenRecord::Parameter::Sort)
    end
  end

  describe "#add_pagination" do
    it "return a parameter class instance" do
      v = common_params.add_pagination
      expect(v).to be_a(GoldenRecord::Parameter::Pagination)
    end
  end
end
