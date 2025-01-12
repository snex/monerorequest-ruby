# frozen_string_literal: true

RSpec.describe Monerorequest::Encoder do
  describe "#initialize" do
    subject(:encode) { described_class.new(req, version) }

    context "with a valid version 1 request" do
      let(:version) { 1 }
      let(:req) do
        {
          "custom_label" => Faker::String.random,
          "sellers_wallet" => "4A#{Faker::Alphanumeric.alphanumeric(number: 93)}",
          "currency" => Faker::Currency.code,
          "amount" => Faker::Number.decimal(l_digits: 5, r_digits: 2),
          "payment_id" => SecureRandom.hex(8),
          "start_date" => DateTime.now.rfc3339,
          "days_per_billing_cycle" => Faker::Number.number(digits: 2),
          "number_of_payments" => Faker::Number.number(digits: 2),
          "change_indicator_url" => Faker::Internet.url
        }
      end

      it "does not raise an error" do
        expect { encode }.not_to raise_error
      end
    end

    context "with an invalid version 1 request" do
      let(:version) { 1 }
      let(:req) do
        {
          "custom_label" => Faker::String.random,
          "sellers_wallet" => "4A#{Faker::Alphanumeric.alphanumeric(number: 93)}",
          "currency" => Faker::Currency.code,
          "amount" => Faker::Number.decimal(l_digits: 5, r_digits: 2),
          "payment_id" => SecureRandom.hex(8),
          "start_date" => DateTime.now.rfc3339,
          "number_of_payments" => Faker::Number.number(digits: 2),
          "change_indicator_url" => Faker::Internet.url
        }
      end

      it "raises an error" do
        expect { encode }.to raise_error(Monerorequest::InvalidRequestError)
      end
    end

    context "with a valid version 2 request" do
      let(:version) { 2 }
      let(:req) do
        {
          "custom_label" => Faker::String.random,
          "sellers_wallet" => "4A#{Faker::Alphanumeric.alphanumeric(number: 93)}",
          "currency" => Faker::Currency.code,
          "amount" => Faker::Number.decimal(l_digits: 5, r_digits: 2),
          "payment_id" => SecureRandom.hex(8),
          "start_date" => DateTime.now.rfc3339,
          "schedule" => "* * 1 * *",
          "number_of_payments" => Faker::Number.number(digits: 2),
          "change_indicator_url" => Faker::Internet.url
        }
      end

      it "does not raise an error" do
        expect { encode }.not_to raise_error
      end
    end

    context "with an invalid version 2 request" do
      let(:version) { 2 }
      let(:req) do
        {
          "custom_label" => Faker::String.random,
          "sellers_wallet" => "4A#{Faker::Alphanumeric.alphanumeric(number: 93)}",
          "currency" => Faker::Currency.code,
          "amount" => Faker::Number.decimal(l_digits: 5, r_digits: 2),
          "payment_id" => SecureRandom.hex(8),
          "start_date" => DateTime.now.rfc3339,
          "number_of_payments" => Faker::Number.number(digits: 2),
          "change_indicator_url" => Faker::Internet.url
        }
      end

      it "raises an error" do
        expect { encode }.to raise_error(Monerorequest::InvalidRequestError)
      end
    end

    context "with an unknown version" do
      let(:version) { 3 }
      let(:req) do
        {
          "custom_label" => Faker::String.random,
          "sellers_wallet" => "4A#{Faker::Alphanumeric.alphanumeric(number: 93)}",
          "currency" => Faker::Currency.code,
          "amount" => Faker::Number.decimal(l_digits: 5, r_digits: 2),
          "payment_id" => SecureRandom.hex(8),
          "start_date" => DateTime.now.rfc3339,
          "schedule" => "* * 1 * *",
          "number_of_payments" => Faker::Number.number(digits: 2),
          "change_indicator_url" => Faker::Internet.url
        }
      end

      it "raises an error" do
        expect do
          encode
        end.to raise_error(Monerorequest::RequestVersionError, "Unknown version: 3. Only 1 and 2 are supported.")
      end
    end
  end

  describe "#encode" do
    # to test encoding, we first encode and then decode and verify because the encoded string
    # varies based on the OS the program is being run on due to the way gzip works.
    subject(:encode) { decoder.decode }

    context "with a V1 request" do
      let(:req) do
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
      let(:encoder) { described_class.new(req, 1) }
      let(:decoder) { Monerorequest::Decoder.new(encoder.encode) }

      it { is_expected.to eq(req) }
    end

    context "with a V2 request" do
      let(:req) do
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
      let(:encoder) { described_class.new(req, 2) }
      let(:decoder) { Monerorequest::Decoder.new(encoder.encode) }

      it { is_expected.to eq(req) }
    end
  end
end
