# frozen_string_literal: true

RSpec.describe Monerorequest::Validator::SellersWallet do
  describe ".validate!" do
    subject { described_class.validate!(data) }

    context "when sellers_wallet is missing" do
      let(:data) { {} }

      it { is_expected.to include("sellers_wallet must be present.") }
    end

    context "when sellers_wallet is not a valid Monero address" do
      let(:data) { { "sellers_wallet" => 1 } }

      before { allow(Monerorequest::MoneroAddress).to receive(:valid?).and_return(false) }

      it { is_expected.to include("sellers_wallet must be a main Monero address.") }
    end

    context "when sellers_wallet is valid" do
      let(:data) { { "sellers_wallet" => 1 } }

      before { allow(Monerorequest::MoneroAddress).to receive(:valid?).and_return(true) }

      it { is_expected.to be_empty }
    end
  end
end
