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
      let(:req) { "monero-request:invalid:somedata" }

      it "raises a RequestVersionError" do
        expect do
          decode
        end.to raise_error(Monerorequest::RequestVersionError, /Unknown version: invalid/)
      end
    end
  end

  describe "#decode" do
    # to test encoding, we first encode and then decode and verify because the encoded string
    # varies based on the OS the program is being run on due to the way gzip works.
    subject(:decode) { decoder.decode }

    let(:decoder) { described_class.new(encoded_request) }
    let(:encoded_request) { Monerorequest::Encoder.new(decoded_request, version).encode }

    context "with a valid version 1 request" do
      let(:version) { 1 }
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
          "version" => version
        }
      end

      it { is_expected.to eq(decoded_request) }
    end

    context "with an invalid version 1 request" do
      let(:encoded_request) do
        "monero-request:1:H4sIAAAAAAACAy2PzUrDQBSFXyXMQlD6M0mmyUxw03dQcSGkk2TapMkkcTJpGsSFPyAqKOJSE" \
          "Vwools3in0aXdil8QWcFlf33Ms597t3D1CelakEDkIYmR1dbwE/pOmIuVEaRD6VmXBLkQAHhFLmTrcrMk5HJRO0I1k" \
          "huzILAqAypRAs9Wvl2+5vLgeFzLibUI8twr8Xj8ffHzeD5u7k9vPsaKeEUO8NtrSlwFrn5+X5fEUjZP5wGjYHs/tVz" \
          "dbmx29rmtZcPl01h7PXr/frdbU3LbnHhJsN3ZzWnKWyAI5FWuC/c6NA0Wwbe3DoQ2j7JmFDonIFSxImCreiqqp3Aeq" \
          "bQYTIrhEJVvm1wcWIER/yCguITBxZxRTh3MZxPKktlGLmJVNcMYpRngjfCycjaDPIQ2HZnhkXuBhn45Doecx7JazjB" \
          "VJSId2ASqZwBjR6bai3dWMDYgdaTo+0FwIq40QdFmUpcPT9P8SkAZeQAQAA"
      end

      it "raises an InvalidRequestError" do
        expect { decode }.to raise_error(Monerorequest::InvalidRequestError)
      end
    end

    context "with a valid version 2 request" do
      let(:version) { 2 }
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
          "version" => version
        }
      end

      it { is_expected.to eq(decoded_request) }
    end

    context "with an invalid version 2 request" do
      let(:version) { 2 }
      let(:encoded_request) do
        "monero-request:2:H4sIAAAAAAACAy1PTUvcQBj+K2HocT8mk+wmm4tYKHiWFS+FYSaZTSYfk+x8mB3EgyyW0goKH" \
          "gUReuqhPRUKIv4WQQ/Sm9gf0Fnr6X2fh+fjfQ8BaVojNEiicAajURQMQFoQkTPMRcZToluJjaxBAgqtu2Q8dmTFR5o" \
          "pPSYc50bxqu1VxYEzGimZSK0T7+69fyWUbhtcE8o2Cd7O0+Xl089f3vP51ZX30UDoR483XwYvX3+cvCL6bjp/OLn2X" \
          "tYXn/e959Pv3+5/H28l6r82s38+3X7w/q7vzly2MA1lErcL3BHbMKEVSIJoAN4Q5plrJChOfcoCNEOTgE6o8ylW10w" \
          "q3BM33d8g3C7MwhrJhaXG5i2v2Ap2cRNPdG2pQFzChekbemBVSSteyljacNkXOZxWPDNIBnrZGJRVVUiXhcn9sunKl" \
          "Ek+K7tV220qNZEaZ0QzV4cgmgyhP/TRHMaJHyZhOHQLhE544A7jrQAJOvoHEKRk4JkBAAA="
      end

      it "raises and InvalidRequestError" do
        expect { decode }.to raise_error(Monerorequest::InvalidRequestError)
      end
    end
  end
end
