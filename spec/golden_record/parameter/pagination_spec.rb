require "spec_helper"

describe GoldenRecord::Parameter::Pagination do
  describe "#build" do
    subject(:pagination) do
      described_class.new(page: page, per_page: per_page, offset: offset).build
    end

    let(:page) do
      2
    end

    let(:per_page) do
      11
    end

    let(:offset) do
      10
    end

    it "returns parameter for paginator" do
      expect(pagination[:start]).to eq(21)
      expect(pagination[:rows]).to eq(11)
    end

    context "when page is nil" do
      let(:page) do
        nil
      end

      it "uses default value" do
        expect(pagination[:start]).to eq(10)
      end
    end

    context "when per_page is nil" do
      let(:per_page) do
        nil
      end

      it "uses default value" do
        expect(pagination[:start]).to eq(20)
        expect(pagination[:rows]).to eq(10)
      end
    end

    context "when offset is nil" do
      let(:offset) do
        nil
      end

      it "uses default value" do
        expect(pagination[:start]).to eq(11)
      end
    end
  end
end
