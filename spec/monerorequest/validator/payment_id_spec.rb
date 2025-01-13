# frozen_string_literal: true

RSpec.describe Monerorequest::Validator::PaymentID do
  describe ".validate!" do
    subject { described_class.validate!(data) }

    context "when payment_id is missing" do
      let(:data) { {} }

      it { is_expected.to include("payment_id must be present.") }
    end

    context "when payment_id is not a valid Monero Payment ID" do
      let(:data) { { "payment_id" => 1 } }

      before { allow(Monerorequest::MoneroPaymentID).to receive(:valid?).and_return(false) }

      it { is_expected.to include("payment_id must be a Monero Payment ID.") }
    end

    context "when payment_id is valid" do
      let(:data) { { "payment_id" => 1 } }

      before { allow(Monerorequest::MoneroPaymentID).to receive(:valid?).and_return(true) }

      it { is_expected.to be_empty }
    end
  end
end
