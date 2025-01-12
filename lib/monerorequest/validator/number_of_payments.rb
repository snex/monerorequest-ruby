# frozen_string_literal: true

module Monerorequest
  module Validator
    # validates the number_of_payments field
    class NumberOfPayments
      def self.validate!(data)
        errors = []
        errors.push("number_of_payments must be present.") unless data.key?("number_of_payments")
        errors.push("number_of_payments must be an Integer.") unless data["number_of_payments"].is_a?(Integer)
        errors.push("number_of_payments must be 0 or positive.") if data["number_of_payments"].to_i.negative?
        errors
      end
    end
  end
end
