# frozen_string_literal: true

require "base64"

module Monerorequest
  module Pipeline
    # pipeline that takes a base64 encoded string and decodes it
    class Base64Decoder
      def self.call(input)
        Base64.strict_decode64(input)
      end
    end
  end
end
