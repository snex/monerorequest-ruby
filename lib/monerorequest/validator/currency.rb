# frozen_string_literal: true

module Monerorequest
  module Validator
    # validates the currency field
    class Currency
      def self.validate!(data)
        errors = []
        errors.push("currency must be present.") unless data.key?("currency")
        errors.push("currency must be a String.") unless data["currency"].is_a?(String)
        errors
      end
    end
  end
end
