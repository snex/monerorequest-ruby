# frozen_string_literal: true

module Monerorequest
  module Validator
    # validates the days_per_billing_cycle field
    class DaysPerBillingCycle
      def self.validate!(data)
        errors = []
        errors.push("days_per_billing_cycle must be present.") unless data.key?("days_per_billing_cycle")
        errors.push("days_per_billing_cycle must be an Integer.") unless data["days_per_billing_cycle"].is_a?(Integer)
        errors.push("days_per_billing_cycle must be positive.") unless data["days_per_billing_cycle"].to_i.positive?
        errors
      end
    end
  end
end
