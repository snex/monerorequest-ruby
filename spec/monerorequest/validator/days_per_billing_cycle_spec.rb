# frozen_string_literal: true

RSpec.describe Monerorequest::Validator::DaysPerBillingCycle do
  describe ".validate!" do
    subject { described_class.validate!(data) }

    context "when days_per_billing_cycle is missing" do
      let(:data) { {} }

      it { is_expected.to include("days_per_billing_cycle must be present.") }
    end

    context "when days_per_billing_cycle is not an Integer" do
      let(:data) { { "days_per_billing_cycle" => "string" } }

      it { is_expected.to include("days_per_billing_cycle must be an Integer.") }
    end

    context "when days_per_billing_cycle is 0" do
      let(:data) { { "days_per_billing_cycle" => 0 } }

      it { is_expected.to include("days_per_billing_cycle must be positive.") }
    end

    context "when days_per_billing_cycle is negative" do
      let(:data) { { "days_per_billing_cycle" => -1 } }

      it { is_expected.to include("days_per_billing_cycle must be positive.") }
    end

    context "when days_per_billing_cycle is valid" do
      let(:data) { { "days_per_billing_cycle" => 1 } }

      it { is_expected.to be_empty }
    end
  end
end
