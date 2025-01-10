# frozen_string_literal: true

RSpec.describe Monerorequest::Encoder do
  context "V1" do
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

    describe "#initialize" do
      subject(:encoder) { described_class.new(request.merge('version' => 1)) }

      context "when custom_label is missing" do
        let(:request) { {} }

        it "contains a message about custom_label missing" do
          expect(encoder.errors).to include("custom_label must be present.")
        end
      end

      context "when custom_label is not a String" do
        let(:request) { { "custom_label" => 1 } }

        it "contains a message about custom_label not being a String" do
          expect(encoder.errors).to include("custom_label must be a String.")
        end
      end

      context "when sellers_wallet is missing" do
        let(:request) { {} }

        it "contains a message about sellers_wallet missing" do
          expect(encoder.errors).to include("sellers_wallet must be present.")
        end
      end

      context "when sellers_wallet is not a main Monero wallet address" do
        let(:request) { { "sellers_wallet" => 123 } }

        it "contains a message about sellers_wallet not being a main Monero address" do
          expect(encoder.errors).to include("sellers_wallet must be a main Monero address.")
        end
      end

      context "when currency is missing" do
        let(:request) { {} }

        it "contains a message about currency missing" do
          expect(encoder.errors).to include("currency must be present.")
        end
      end

      context "when currency is not a String" do
        let(:request) { { "currency " => 1 } }

        it "contains a message about currency not being a String" do
          expect(encoder.errors).to include("currency must be a String.")
        end
      end

      context "when amount is missing" do
        let(:request) { {} }

        it "contains a message about amount missing" do
          expect(encoder.errors).to include("amount must be present.")
        end
      end

      context "when amount is not a Numeric" do
        let(:request) { { "amount" => "abc" } }

        it "contains a message about amount not being a Numeric" do
          expect(encoder.errors).to include("amount must be a Numeric.")
        end
      end

      context "when payment_id is missing" do
        let(:request) { {} }

        it "contains a message about payment_id missing" do
          expect(encoder.errors).to include("payment_id must be present.")
        end
      end

      context "when payment_id is not a Monero Payment ID" do
        let(:request) { { "payment_id" => 1 } }

        it "contains a message about payment_id not being a Monero Payment ID" do
          expect(encoder.errors).to include("payment_id must be a Monero Payment ID.")
        end
      end

      context "when start_date is missing" do
        let(:request) { {} }

        it "contains a message about start_date missing" do
          expect(encoder.errors).to include("start_date must be present.")
        end
      end

      context "when start_date is not a String" do
        let(:request) { { "start_date" => 1 } }

        it "contains a message about start_date not being a String" do
          expect(encoder.errors).to include("start_date must be a String.")
        end
      end

      context "when start_date is not an RFC3339 timestamp" do
        let(:request) { { "start_date" => "abc" } }

        it "contains a message about start_date not being an RFC3339 timestamp" do
          expect(encoder.errors).to include("start_date must be an RFC3339 timestamp.")
        end
      end

      context "when days_per_billing_cycle is missing" do
        let(:request) { {} }

        it "contains a message about days_per_billing_cycle missing" do
          expect(encoder.errors).to include("days_per_billing_cycle must be present.")
        end
      end

      context "when days_per_billing_cycle is not a Integer" do
        let(:request) { { "days_per_billing_cycle" => "abc" } }

        it "contains a message about days_per_billing_cycle not being a Integer" do
          expect(encoder.errors).to include("days_per_billing_cycle must be a Integer.")
        end
      end

      context "when change_indicator_url is missing" do
        let(:request) { {} }

        it "contains a message about change_indicator_url missing" do
          expect(encoder.errors).to include("change_indicator_url must be present.")
        end
      end

      context "when change_indicator_url is not a String" do
        let(:request) { { "days_per_billing_cycle" => 1 } }

        it "contains a message about change_indicator_url not being a String" do
          expect(encoder.errors).to include("change_indicator_url must be a String.")
        end
      end

      context "when change_indicator_url is not a URL" do
        let(:request) { { "change_indicator_url" => 1 } }

        it "contains a message about change_indicator_url not being a URL" do
          expect(encoder.errors).to include("change_indicator_url must be a URL.")
        end
      end
    end

    describe "#encode" do
      # to test encoding, we first encode and then decode and verify because the encoded string
      # varies based on the OS the program is being run on due to the way gzip works.
      subject(:encode) { decoder.decode }

      let(:encoder) { described_class.new(decoded_request) }
      let(:decoder) { Monerorequest::Decoder.new(encoder.encode(request_version)) }

      context "when invalid request_version is sent" do
        let(:request_version) { 3 }

        it "raises an error" do
          expect { encode }.to raise_error(Monerorequest::RequestVersionError, "Request Versions 1 and 2 are supported.")
        end
      end

      context "when valid request_version is sent" do
        let(:request_version) { 1 }

        it { is_expected.to eq(decoded_request) }
      end
    end
  end

  context "V2" do
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
        "schedule" => '* * * * *',
        "version" => 2
      }
    end

    describe "#initialize" do
      subject(:encoder) { described_class.new(request.merge('version' => 2)) }

      context "when custom_label is missing" do
        let(:request) { {} }

        it "contains a message about custom_label missing" do
          expect(encoder.errors).to include("custom_label must be present.")
        end
      end

      context "when custom_label is not a String" do
        let(:request) { { "custom_label" => 1 } }

        it "contains a message about custom_label not being a String" do
          expect(encoder.errors).to include("custom_label must be a String.")
        end
      end

      context "when sellers_wallet is missing" do
        let(:request) { {} }

        it "contains a message about sellers_wallet missing" do
          expect(encoder.errors).to include("sellers_wallet must be present.")
        end
      end

      context "when sellers_wallet is not a main Monero wallet address" do
        let(:request) { { "sellers_wallet" => 123 } }

        it "contains a message about sellers_wallet not being a main Monero address" do
          expect(encoder.errors).to include("sellers_wallet must be a main Monero address.")
        end
      end

      context "when currency is missing" do
        let(:request) { {} }

        it "contains a message about currency missing" do
          expect(encoder.errors).to include("currency must be present.")
        end
      end

      context "when currency is not a String" do
        let(:request) { { "currency " => 1 } }

        it "contains a message about currency not being a String" do
          expect(encoder.errors).to include("currency must be a String.")
        end
      end

      context "when amount is missing" do
        let(:request) { {} }

        it "contains a message about amount missing" do
          expect(encoder.errors).to include("amount must be present.")
        end
      end

      context "when amount is not a Numeric" do
        let(:request) { { "amount" => "abc" } }

        it "contains a message about amount not being a Numeric" do
          expect(encoder.errors).to include("amount must be a Numeric.")
        end
      end

      context "when payment_id is missing" do
        let(:request) { {} }

        it "contains a message about payment_id missing" do
          expect(encoder.errors).to include("payment_id must be present.")
        end
      end

      context "when payment_id is not a Monero Payment ID" do
        let(:request) { { "payment_id" => 1 } }

        it "contains a message about payment_id not being a Monero Payment ID" do
          expect(encoder.errors).to include("payment_id must be a Monero Payment ID.")
        end
      end

      context "when start_date is missing" do
        let(:request) { {} }

        it "contains a message about start_date missing" do
          expect(encoder.errors).to include("start_date must be present.")
        end
      end

      context "when start_date is not a String" do
        let(:request) { { "start_date" => 1 } }

        it "contains a message about start_date not being a String" do
          expect(encoder.errors).to include("start_date must be a String.")
        end
      end

      context "when start_date is not an RFC3339 timestamp" do
        let(:request) { { "start_date" => "abc" } }

        it "contains a message about start_date not being an RFC3339 timestamp" do
          expect(encoder.errors).to include("start_date must be an RFC3339 timestamp.")
        end
      end

      context "when schedule is missing" do
        let(:request) { {} }

        it "contains a message about schedule missing" do
          expect(encoder.errors).to include("schedule must be present.")
        end
      end

      context "when schedule is not a valid Cron" do
        let(:request) { { "schedule" => "abc" } }

        it "contains a message about schedule not being a valid Cron" do
          expect(encoder.errors).to include("schedule must be a valid Cron.")
        end
      end

      context "when change_indicator_url is missing" do
        let(:request) { {} }

        it "contains a message about change_indicator_url missing" do
          expect(encoder.errors).to include("change_indicator_url must be present.")
        end
      end

      context "when change_indicator_url is not a String" do
        let(:request) { { "days_per_billing_cycle" => 1 } }

        it "contains a message about change_indicator_url not being a String" do
          expect(encoder.errors).to include("change_indicator_url must be a String.")
        end
      end

      context "when change_indicator_url is not a URL" do
        let(:request) { { "change_indicator_url" => 1 } }

        it "contains a message about change_indicator_url not being a URL" do
          expect(encoder.errors).to include("change_indicator_url must be a URL.")
        end
      end
    end

    describe "#encode" do
      # to test encoding, we first encode and then decode and verify because the encoded string
      # varies based on the OS the program is being run on due to the way gzip works.
      subject(:encode) { decoder.decode }

      let(:encoder) { described_class.new(decoded_request) }
      let(:decoder) { Monerorequest::Decoder.new(encoder.encode(request_version)) }

      context "when invalid request_version is sent" do
        let(:request_version) { 3 }

        it "raises an error" do
          expect { encode }.to raise_error(Monerorequest::RequestVersionError, "Request Versions 1 and 2 are supported.")
        end
      end

      context "when valid request_version is sent" do
        let(:request_version) { 2 }

        it { is_expected.to eq(decoded_request)}
      end
    end
  end
end
