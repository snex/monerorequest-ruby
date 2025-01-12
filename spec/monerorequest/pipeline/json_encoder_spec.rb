# frozen_string_literal: true

RSpec.describe Monerorequest::Pipeline::JSONEncoder do
  describe ".call" do
    subject(:call) { described_class.call(data) }

    context "with valid data" do
      let(:data) { { "hello" => "goodbye", "goodbye" => "hello" } }

      it { is_expected.to eq("{\"goodbye\":\"hello\",\"hello\":\"goodbye\"}") }
    end

    context "with invalid data" do
      let(:data) { "invalid" }

      it "raises an InvalidRequest" do
        expect { call }.to raise_error(Monerorequest::InvalidRequestError, "Request must be a Hash.")
      end
    end
  end
end
