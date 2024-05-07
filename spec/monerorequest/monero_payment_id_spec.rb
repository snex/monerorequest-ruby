# frozen_string_literal: true

RSpec.describe Monerorequest::MoneroPaymentID do
  describe ".valid?" do
    subject { described_class.valid?(payment_id) }

    context "when payment_id is not a String" do
      let(:payment_id) { nil }

      it { is_expected.to be false }
    end

    context "when payment_id is not 16 characters long" do
      let(:payment_id) { "1" }

      it { is_expected.to be false }
    end

    context "when payment_id is not made entirely of hex characters" do
      let(:payment_id) { "Q" * 16 }

      it { is_expected.to be false }
    end

    context "when all criteria are met" do
      let(:payment_id) { SecureRandom.hex(8) }

      it { is_expected.to be true }
    end
  end
end
