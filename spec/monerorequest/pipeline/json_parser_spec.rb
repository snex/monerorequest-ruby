# frozen_string_literal: true

RSpec.describe Monerorequest::Pipeline::JSONParser do
  describe ".call" do
    subject(:call) { described_class.call(data) }

    context "with valid data" do
      let(:data) { "{\"hello\":\"goodbye\"}" }

      it { is_expected.to eq({ "hello" => "goodbye" }) }
    end

    context "with invalid data" do
      let(:data) { "invalid" }

      it "raises an ArgumentError" do
        expect { call }.to raise_error(JSON::ParserError, "unexpected token at 'invalid'")
      end
    end
  end
end
