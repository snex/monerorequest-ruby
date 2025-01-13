# frozen_string_literal: true

RSpec.describe Monerorequest::Validator::Amount do
  describe ".validate!" do
    subject { described_class.validate!(data) }

    context "when amount is missing" do
      let(:data) { {} }

      it { is_expected.to include("amount must be present.") }
    end

    context "when amount is not a Numeric" do
      let(:data) { { "amount" => "string" } }

      it { is_expected.to include("amount must be a Numeric.") }
    end

    context "when amount is 0" do
      let(:data) { { "amount" => 0 } }

      it { is_expected.to include("amount must be positive.") }
    end

    context "when amount is negative" do
      let(:data) { { "amount" => -1 } }

      it { is_expected.to include("amount must be positive.") }
    end

    context "when amount is valid" do
      let(:data) { { "amount" => 69.420 } }

      it { is_expected.to be_empty }
    end
  end
end
