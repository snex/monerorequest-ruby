# frozen_string_literal: true

require "json"

module Monerorequest
  module Pipeline
    # pipeline that takes a hash, sorts by keys, then converts to valid JSON in ASCII encoding
    class JSONEncoder
      def self.call(input)
        raise InvalidRequestError, "Request must be a Hash." unless input.is_a?(Hash)

        input.sort.to_h.to_json.force_encoding("ascii")
      end
    end
  end
end
