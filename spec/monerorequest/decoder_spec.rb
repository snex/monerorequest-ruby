# frozen_string_literal: true

RSpec.describe Monerorequest::Decoder do
  describe "#initialize" do
    subject(:decode) { described_class.new(req) }

    context "with a version 1 request" do
      let(:req) { "monero-request:1:somedata" }

      it "does not raise an error" do
        expect { decode }.not_to raise_error
      end
    end

    context "with a version 2 request" do
      let(:req) { "monero-request:2:somedata" }

      it "does not raise an error" do
        expect { decode }.not_to raise_error
      end
    end

    context "with an unknown version request" do
      let(:req) { "monero-request:3:somedata" }

      it "raises a RequestVersionError" do
        expect do
          decode
        end.to raise_error(Monerorequest::RequestVersionError, "Unknown version: 3. Only 1 and 2 are supported.")
      end
    end
  end

  describe "#decode" do
    # to test encoding, we first encode and then decode and verify because the encoded string
    # varies based on the OS the program is being run on due to the way gzip works.
    subject(:decode) { decoder.decode }

    context "with a version 1 request" do
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
      let(:decoder) { described_class.new(encoded_request) }
      let(:encoded_request) { Monerorequest::Encoder.new(decoded_request).encode(1) }

      it { is_expected.to eq(decoded_request) }
    end

    context "with a version 2 request" do
      let(:decoded_request) do
        {
          "custom_label" => Faker::String.random,
          "sellers_wallet" => "4A#{Faker::Alphanumeric.alphanumeric(number: 93)}",
          "currency" => Faker::Currency.code,
          "amount" => Faker::Number.decimal(l_digits: 5, r_digits: 2),
          "payment_id" => SecureRandom.hex(8),
          "start_date" => DateTime.now.rfc3339,
          "schedule" => "* * 1 * *",
          "number_of_payments" => Faker::Number.number(digits: 2),
          "change_indicator_url" => Faker::Internet.url,
          "version" => 2
        }
      end
      let(:decoder) { described_class.new(encoded_request) }
      let(:encoded_request) { Monerorequest::Encoder.new(decoded_request).encode(2) }

      it { is_expected.to eq(decoded_request) }
    end
  end
end
