# frozen_string_literal: true

RSpec.describe Monerorequest::Validator::Schedule do
  describe ".validate!" do
    subject { described_class.validate!(data) }

    context "when schedule is missing" do
      let(:data) { {} }

      it { is_expected.to include("schedule must be present.") }
    end

    context "when schedule is not a valid Cron" do
      let(:data) { { "schedule" => "string" } }

      before { allow(Monerorequest::Cron).to receive(:valid?).and_return(false) }

      it { is_expected.to include("schedule must be a valid Cron.") }
    end

    context "when schedule is valid" do
      let(:data) { { "schedule" => "string" } }

      before { allow(Monerorequest::Cron).to receive(:valid?).and_return(true) }

      it { is_expected.to be_empty }
    end
  end
end
