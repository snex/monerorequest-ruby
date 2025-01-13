# frozen_string_literal: true

require "base64"

module Monerorequest
  module Pipeline
    # pipeline that takes a string and base64 encodes it
    class Base64Encoder
      def self.call(input)
        Base64.strict_encode64(input)
      end
    end
  end
end
