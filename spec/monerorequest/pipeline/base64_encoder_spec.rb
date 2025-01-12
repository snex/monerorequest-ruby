# frozen_string_literal: true

RSpec.describe Monerorequest::Pipeline::Base64Encoder do
  describe ".call" do
    subject(:call) { described_class.call(data) }

    let(:data) { "hello" }

    it { is_expected.to eq("aGVsbG8=") }
  end
end
