# frozen_string_literal: true

module Monerorequest
  # class to Decode an encoded Monerorequest
  class Decoder
    def initialize(request)
      @request = request
    end

    def decode
      _, version, encoded_str = @request.split(":")
      raise RequestVersionError, "Request Versions 1 and 2 are supported." unless [1, 2].include?(version.to_i)

      compressed_data = Base64.decode64(encoded_str)
      json_str = Zlib::GzipReader.new(StringIO.new(compressed_data)).read
      decoded_hash = JSON.parse(json_str)
      decoded_hash["version"] = version.to_i
      decoded_hash
    end
  end
end
