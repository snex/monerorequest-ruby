# frozen_string_literal: true

RSpec.describe Monerorequest::Validator::ChangeIndicatorURL do
  describe ".validate!" do
    subject { described_class.validate!(data) }

    context "when change_indicator_url is missing" do
      let(:data) { {} }

      it { is_expected.to be_empty }
    end

    context "when change_indicator_url is not a String" do
      let(:data) { { "change_indicator_url" => 1 } }

      it { is_expected.to include("change_indicator_url must be a String.") }
    end

    context "when change_indicator_url is not a valid URL" do
      let(:data) { { "change_indicator_url" => "string" } }

      it { is_expected.to include("change_indicator_url must be a URL.") }
    end

    context "when change_indicator_url is valid" do
      let(:data) { { "change_indicator_url" => Faker::Internet.url } }

      it { is_expected.to be_empty }
    end
  end
end
