# frozen_string_literal: true

RSpec.describe Monerorequest::Validator::CustomLabel do
  describe ".validate!" do
    subject { described_class.validate!(data) }

    context "when custom_label is missing" do
      let(:data) { {} }

      it { is_expected.to include("custom_label must be present.") }
    end

    context "when custom_label is not a String" do
      let(:data) { { "custom_label" => 1 } }

      it { is_expected.to include("custom_label must be a String.") }
    end

    context "when custom_label is valid" do
      let(:data) { { "custom_label" => "custom label" } }

      it { is_expected.to be_empty }
    end
  end
end
