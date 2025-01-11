# frozen_string_literal: true

RSpec.describe Monerorequest::Pipeline::GzipReader do
  describe ".call" do
    subject(:call) { described_class.call(data) }

    context "with valid data" do
      let(:data) do
        "\u001F\x8B\b\u0000\u0000\u0000\u0000\u0000" \
          "\u0002\u0003\xCBH\xCD\xC9\xC9\a\u0000\x86" \
          "\xA6\u00106\u0005\u0000\u0000\u0000"
      end

      it { is_expected.to eq("hello") }
    end

    context "with invalid data" do
      let(:data) { "invalid" }

      it "raises an ArgumentError" do
        expect { call }.to raise_error(Zlib::GzipFile::Error, "not in gzip format")
      end
    end
  end
end
