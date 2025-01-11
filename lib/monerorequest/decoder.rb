# frozen_string_literal: true

require_relative "decoder/v1"
require_relative "decoder/v2"

module Monerorequest
  # class to choose a proper Decoder Version and then pass the encoded data to it for decoding
  class Decoder
    def initialize(request)
      @request = request
      _, @version, @encoded_str = @request.split(":")
      @decoder = case @version.to_i
                 when 1
                   Decoder::V1
                 when 2
                   Decoder::V2
                 else
                   raise RequestVersionError, "Unknown version: #{@version}. Only 1 and 2 are supported."
                 end
    end

    def decode
      data = @encoded_str

      @decoder::PIPELINES.each do |pipeline|
        data = pipeline.call(data)
      end

      data["version"] = @version.to_i
      data
    end
  end
end
