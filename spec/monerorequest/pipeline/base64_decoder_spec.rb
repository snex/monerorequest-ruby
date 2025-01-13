# frozen_string_literal: true

RSpec.describe Monerorequest::Pipeline::Base64Decoder do
  describe ".call" do
    subject(:call) { described_class.call(data) }

    context "with valid data" do
      let(:data) { "aGVsbG8=" }

      it { is_expected.to eq("hello") }
    end

    context "with invalid data" do
      let(:data) { "!!!" }

      it "raises an ArgumentError" do
        expect { call }.to raise_error(ArgumentError, "invalid base64")
      end
    end
  end
end
