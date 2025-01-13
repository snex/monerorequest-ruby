# frozen_string_literal: true

RSpec.describe Monerorequest do
  it "has a version number" do
    expect(Monerorequest::VERSION).not_to be_nil
  end

  it "has SUPPORTED_MR_VERSIONS" do
    expect(Monerorequest::SUPPORTED_MR_VERSIONS).to eq([1, 2])
  end
end
