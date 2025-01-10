# frozen_string_literal: true

RSpec.describe Monerorequest::Decoder do
  context "v1" do
    let(:decoded_request) do
      {
        "custom_label" => Faker::String.random,
        "sellers_wallet" => "4A#{Faker::Alphanumeric.alphanumeric(number: 93)}",
        "currency" => Faker::Currency.code,
        "amount" => Faker::Number.decimal(l_digits: 5, r_digits: 2),
        "payment_id" => SecureRandom.hex(8),
        "start_date" => DateTime.now.rfc3339,
        "days_per_billing_cycle" => Faker::Number.number(digits: 2),
        "number_of_payments" => Faker::Number.number(digits: 2),
        "change_indicator_url" => Faker::Internet.url,
        "version" => 1
      }
    end

    describe "#decode" do
      # to test encoding, we first encode and then decode and verify because the encoded string
      # varies based on the OS the program is being run on due to the way gzip works.
      subject(:decode) { decoder.decode }

      let(:decoder) { described_class.new(encoded_request) }
      let(:encoded_request) { Monerorequest::Encoder.new(decoded_request).encode(request_version) }

      context "when invalid request_version is sent" do
        let(:request_version) { 3 }

        it "raises an error" do
          expect { decode }.to raise_error(Monerorequest::RequestVersionError, "Request Versions 1 and 2 are supported.")
        end
      end

      context "when valid request_version is sent" do
        let(:request_version) { 1 }

        it { is_expected.to eq(decoded_request) }
      end
    end
  end

  context "v2" do
    let(:decoded_request) do
      {
        "custom_label" => Faker::String.random,
        "sellers_wallet" => "4A#{Faker::Alphanumeric.alphanumeric(number: 93)}",
        "currency" => Faker::Currency.code,
        "amount" => Faker::Number.decimal(l_digits: 5, r_digits: 2),
        "payment_id" => SecureRandom.hex(8),
        "start_date" => DateTime.now.rfc3339,
        "days_per_billing_cycle" => Faker::Number.number(digits: 2),
        "number_of_payments" => Faker::Number.number(digits: 2),
        "change_indicator_url" => Faker::Internet.url,
        "version" => 2
      }
    end

    describe "#decode" do
      # to test encoding, we first encode and then decode and verify because the encoded string
      # varies based on the OS the program is being run on due to the way gzip works.
      subject(:decode) { decoder.decode }

      let(:decoder) { described_class.new(encoded_request) }
      let(:encoded_request) { Monerorequest::Encoder.new(decoded_request).encode(request_version) }

      context "when invalid request_version is sent" do
        let(:request_version) { 3 }

        it "raises an error" do
          expect { decode }.to raise_error(Monerorequest::RequestVersionError, "Request Versions 1 and 2 are supported.")
        end
      end

      context "when valid request_version is sent" do
        let(:request_version) { 2 }

        it { is_expected.to eq(decoded_request) }
      end
    end
  end
end
