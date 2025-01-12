# frozen_string_literal: true

module Monerorequest
  module Validator
    # validates the amount field
    class Amount
      def self.validate!(data)
        errors = []
        errors.push("amount must be present.") unless data.key?("amount")
        errors.push("amount must be a Numeric.") unless data["amount"].is_a?(Numeric)
        errors.push("amount must be positive.") unless data["amount"].to_f.positive?
        errors
      end
    end
  end
end
