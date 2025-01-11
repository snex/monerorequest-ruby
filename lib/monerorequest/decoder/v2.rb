# frozen_string_literal: true

require_relative "../pipeline/base64_decoder"
require_relative "../pipeline/gzip_reader"
require_relative "../pipeline/json_parser"

module Monerorequest
  class Decoder
    # class to decode Version 2 requests
    class V2
      PIPELINES = [
        Monerorequest::Pipeline::Base64Decoder,
        Monerorequest::Pipeline::GzipReader,
        Monerorequest::Pipeline::JSONParser
      ].freeze
    end
  end
end
