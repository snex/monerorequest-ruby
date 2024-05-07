# frozen_string_literal: true

RSpec.describe Monerorequest::MoneroAddress do
  describe ".valid?" do
    subject { described_class.valid?(address) }

    context "when address is not a String" do
      let(:address) { nil }

      it { is_expected.to be false }
    end

    context "when address doesnt start with 4" do
      let(:address) { "8" }

      it { is_expected.to be false }
    end

    context "when the second character is not a number, A, or B" do
      let(:address) { "4C" }

      it { is_expected.to be false }
    end

    context "when the address is not 95 characters long" do
      let(:address) { "4Ax" }

      it { is_expected.to be false }
    end

    context "when all criteria are met" do
      let(:allowed_2nd_char) { %w[0 1 2 3 4 5 6 7 8 9 A B].sample }
      let(:address) { "4#{allowed_2nd_char}#{SecureRandom.alphanumeric(93)}" }

      it { is_expected.to be true }
    end
  end
end
