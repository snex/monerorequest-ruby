# frozen_string_literal: true

RSpec.describe Monerorequest::Validator::Currency do
  describe ".validate!" do
    subject { described_class.validate!(data) }

    context "when currency is missing" do
      let(:data) { {} }

      it { is_expected.to include("currency must be present.") }
    end

    context "when currency is not a String" do
      let(:data) { { "currency" => 1 } }

      it { is_expected.to include("currency must be a String.") }
    end

    context "when currency is valid" do
      let(:data) { { "currency" => "currency" } }

      it { is_expected.to be_empty }
    end
  end
end
