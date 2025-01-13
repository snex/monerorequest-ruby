# frozen_string_literal: true

RSpec.describe Monerorequest::V2 do
  let(:expected_validators) do
    [
      Monerorequest::Validator::CustomLabel,
      Monerorequest::Validator::SellersWallet,
      Monerorequest::Validator::Currency,
      Monerorequest::Validator::Amount,
      Monerorequest::Validator::PaymentID,
      Monerorequest::Validator::StartDate,
      Monerorequest::Validator::Schedule,
      Monerorequest::Validator::NumberOfPayments,
      Monerorequest::Validator::ChangeIndicatorURL
    ]
  end

  it "lists the validators" do
    expect(described_class::VALIDATORS).to match_array(expected_validators)
  end

  describe Monerorequest::V2::Encoder do
    let(:expected_pipelines) do
      [
        Monerorequest::Pipeline::JSONEncoder,
        Monerorequest::Pipeline::GzipWriter,
        Monerorequest::Pipeline::Base64Encoder
      ]
    end

    it "lists the pipelines in the correct order" do
      expect(described_class::PIPELINES).to eq(expected_pipelines)
    end
  end

  describe Monerorequest::V2::Decoder do
    let(:expected_pipelines) do
      [
        Monerorequest::Pipeline::Base64Decoder,
        Monerorequest::Pipeline::GzipReader,
        Monerorequest::Pipeline::JSONParser
      ]
    end

    it "lists the pipelines in the correct order" do
      expect(described_class::PIPELINES).to eq(expected_pipelines)
    end
  end
end
