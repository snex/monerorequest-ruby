# frozen_string_literal: true

module Monerorequest
  # class to Decode an encoded Monerorequest
  class Decoder
    def initialize(request)
      @request = request
    end

    def decode
      _, version, encoded_str = @request.split(":")
      raise RequestVersionError, "Only Request Version 1 is supported." unless version == "1"

      compressed_data = Base64.decode64(encoded_str)
      json_str = Zlib::GzipReader.new(StringIO.new(compressed_data)).read
      JSON.parse(json_str)
    end
  end
end
