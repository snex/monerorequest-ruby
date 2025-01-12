# frozen_string_literal: true

RSpec.describe Monerorequest::Cron do
  describe ".valid_minutes?" do
    subject { described_class.valid_minutes?(minutes) }

    context "when minute is in 0..59" do
      let(:minutes) { (0..59).to_a }

      it { is_expected.to be true }
    end

    context "when minute is *" do
      let(:minutes) { ["*"] }

      it { is_expected.to be true }
    end

    context "when minutes are invalid" do
      let(:minutes) { ["a"] }

      it { is_expected.to be false }
    end
  end

  describe ".valid_hours?" do
    subject { described_class.valid_hours?(hours) }

    context "when hour is in 0..23" do
      let(:hours) { (0..23).to_a }

      it { is_expected.to be true }
    end

    context "when hour is *" do
      let(:hours) { ["*"] }

      it { is_expected.to be true }
    end

    context "when hours are invalid" do
      let(:hours) { ["a"] }

      it { is_expected.to be false }
    end
  end

  describe ".valid_days?" do
    subject { described_class.valid_days?(days) }

    context "when day is in 1..31" do
      let(:days) { (1..31).to_a }

      it { is_expected.to be true }
    end

    context "when day is *" do
      let(:days) { ["*"] }

      it { is_expected.to be true }
    end

    context "when days are invalid" do
      let(:days) { ["a"] }

      it { is_expected.to be false }
    end
  end

  describe ".valid_months?" do
    subject { described_class.valid_months?(months) }

    context "when month is in MONTH_CODES" do
      let(:months) { (1..12).to_a + described_class::MONTH_CODES }

      it { is_expected.to be true }
    end

    context "when month *" do
      let(:months) { ["*"] }

      it { is_expected.to be true }
    end

    context "when months are invalid" do
      let(:months) { ["a"] }

      it { is_expected.to be false }
    end
  end

  describe ".valid_dow?" do
    subject { described_class.valid_dow?(dow) }

    context "when dow is in DOW_CODES" do
      let(:dow) { described_class::DOW_CODES }

      it { is_expected.to be true }
    end

    context "when dow is *" do
      let(:dow) { ["*"] }

      it { is_expected.to be true }
    end

    context "when dows are invalid" do
      let(:dow) { ["a"] }

      it { is_expected.to be false }
    end
  end

  describe ".parse" do
    subject { described_class.parse(cron) }

    context "when schedule has too many entries" do
      let(:cron) { "* * * * * *" }

      it { is_expected.to be false }
    end

    context "when schedule has too few entries" do
      let(:cron) { "* * * *" }

      it { is_expected.to be false }
    end

    context "when schedule has 5 entries" do
      let(:cron) { "* * * * *" }
      let(:expected) do
        {
          "minutes" => ["*"],
          "hours" => ["*"],
          "days" => ["*"],
          "months" => ["*"],
          "dow" => ["*"]
        }
      end

      it { is_expected.to eq(expected) }
    end

    context "when schedule has delimited entries" do
      let(:cron) { "24,36 2-4, 15,21 2,apr wed-fri" }
      let(:expected) do
        {
          "minutes" => %w[24 36],
          "hours" => %w[2 4],
          "days" => %w[15 21],
          "months" => %w[2 apr],
          "dow" => %w[wed fri]
        }
      end

      it { is_expected.to eq(expected) }
    end
  end
end
