# frozen_string_literal: true

RSpec.describe Monerorequest::Decoder::V2 do
  it "lists the pipelines in the correct order" do
    expect(described_class::PIPELINES).to eq([Monerorequest::Pipeline::Base64Decoder,
                                              Monerorequest::Pipeline::GzipReader,
                                              Monerorequest::Pipeline::JSONParser])
  end
end
