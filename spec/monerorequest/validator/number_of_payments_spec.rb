# frozen_string_literal: true

RSpec.describe Monerorequest::Validator::NumberOfPayments do
  describe ".validate!" do
    subject { described_class.validate!(data) }

    context "when number_of_payments is missing" do
      let(:data) { {} }

      it { is_expected.to include("number_of_payments must be present.") }
    end

    context "when number_of_payments is not an Integer" do
      let(:data) { { "number_of_payments" => "string" } }

      it { is_expected.to include("number_of_payments must be an Integer.") }
    end

    context "when number_of_payments is 0" do
      let(:data) { { "number_of_payments" => 0 } }

      it { is_expected.to be_empty }
    end

    context "when number_of_payments is negative" do
      let(:data) { { "number_of_payments" => -1 } }

      it { is_expected.to include("number_of_payments must be 0 or positive.") }
    end

    context "when number_of_payments is valid" do
      let(:data) { { "number_of_payments" => 1 } }

      it { is_expected.to be_empty }
    end
  end
end
