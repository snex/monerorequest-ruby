# frozen_string_literal: true

RSpec.describe Monerorequest::Pipeline::GzipWriter do
  describe ".call" do
    subject(:call) { described_class.call(data) }

    let(:data) { "hello" }
    let(:expected) do
      "\u001F\x8B\b\u0000\u0000\u0000\u0000\u0000" \
        "\u0002\u0003\xCBH\xCD\xC9\xC9\a\u0000\x86" \
        "\xA6\u00106\u0005\u0000\u0000\u0000"
    end

    it { is_expected.to eq(expected) }
  end
end
