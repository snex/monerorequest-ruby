# frozen_string_literal: true

RSpec.describe Monerorequest::Validator::StartDate do
  describe ".validate!" do
    subject { described_class.validate!(data) }

    context "when start_date is missing" do
      let(:data) { {} }

      it { is_expected.to include("start_date must be present.") }
    end

    context "when start_date is not a String" do
      let(:data) { { "start_date" => 1 } }

      it { is_expected.to include("start_date must be a String.") }
    end

    context "when start_date is not a valid RFC3339 timestamp" do
      let(:data) { { "start_date" => "string" } }

      before { allow(DateTime).to receive(:rfc3339).and_raise(Date::Error) }

      it { is_expected.to include("start_date must be an RFC3339 timestamp.") }
    end

    context "when start_date is valid" do
      let(:data) { { "start_date" => "string" } }

      before { allow(DateTime).to receive(:rfc3339).and_return(true) }

      it { is_expected.to be_empty }
    end
  end
end
