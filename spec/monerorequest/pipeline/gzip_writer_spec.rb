# frozen_string_literal: true

RSpec.describe Monerorequest::Pipeline::GzipWriter do
  # to properly test this, we need to gzip and then gunzip
  # and compare the original string, because the output data
  # will vary based on the OS running the code
  describe ".call" do
    subject(:call) { Zlib::GzipReader.new(StringIO.new(described_class.call(data))).read }

    let(:data) { "hello" }

    it { is_expected.to eq(data) }
  end
end
