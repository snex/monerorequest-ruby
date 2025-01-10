# frozen_string_literal: true

RSpec.describe Monerorequest::Cron do
  describe ".valid?" do
    subject { described_class.valid?(cron) }
  end

  describe ".valid_minutes?" do
    subject { described_class.valid_minutes?(minutes) }

    context "when minutes are valid" do
      let(:minutes) { (0..59).to_a }

      it { is_expected.to be true }

      let(:minutes) { ["*"] }

      it { is_expected.to be true }
    end

    context "when minutes are invalid" do
      let(:minutes) { ['a'] }

      it { is_expected.to be false }
    end
  end

  describe ".valid_hours?" do
    subject { described_class.valid_hours?(hours) }

    context "when hours are valid" do
      let(:hours) { (0..23).to_a }

      it { is_expected.to be true }

      let(:hours) { ["*"] }

      it { is_expected.to be true }
    end

    context "when hours are invalid" do
      let(:hours) { ['a'] }

      it { is_expected.to be false }
    end
  end

  describe ".valid_days?" do
    subject { described_class.valid_days?(days) }

    context "when days are valid" do
      let(:days) { (1..31).to_a }

      it { is_expected.to be true }

      let(:days) { ["*"] }

      it { is_expected.to be true }
    end

    context "when days are invalid" do
      let(:days) { ['a'] }

      it { is_expected.to be false }
    end
  end

  describe ".valid_months?" do
    subject { described_class.valid_months?(months) }

    context "when months are valid" do
      let(:months) { (1..12).to_a + described_class.MONTH_CODES }

      it { is_expected.to be true }

      let(:months) { ["*"] }

      it { is_expected.to be true }
    end

    context "when months are invalid" do
      let(:months) { ['a'] }

      it { is_expected.to be false }
    end
  end

  describe ".valid_dow?" do
    subject { described_class.valid_dow?(dow) }

    context "when dows are valid" do
      let(:dow) { described_class.DOW_CODES }

      it { is_expected.to be true }

      let(:dow) { ["*"] }

      it { is_expected.to be true }
    end

    context "when dows are invalid" do
      let(:dow) { ['a'] }

      it { is_expected.to be false }
    end
  end

  describe ".parse" do
    subject { described_class.parse(cron) }

    context "when schedule doesn't have 5 entries" do
      let(:cron) { '* * * * * *' }

      it { is_expected.to be false }

      let(:cron) { '* * * *' }

      it { is_expected.to be false }
    end

    context "when schedule has 5 entries" do
      let(:cron) { '* * * * *' }

      it "should return a parsed hash" do
        expect(subject['minutes']).to eq ['*']
        expect(subject['hours']).to eq ['*']
        expect(subject['days']).to eq ['*']
        expect(subject['months']).to eq ['*']
        expect(subject['dow']).to eq ['*']
      end
    end

    context "when schedule has delimited entries" do
      let(:cron) { '24,36 2-4, 15,21 2,apr wed-fri' }

      it "should return arrays" do
        expect(subject['minutes']).to eq(['24', '36'])
        expect(subject['hours']).to eq(['2', '4'])
        expect(subject['days']).to eq(['15', '21'])
        expect(subject['months']).to eq(['2', 'apr'])
        expect(subject['dow']).to eq(['wed', 'fri'])
      end
    end
  end
end
