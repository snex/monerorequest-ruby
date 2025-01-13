# frozen_string_literal: true

module Monerorequest
  module Validator
    # validates the payment_id field
    class PaymentID
      def self.validate!(data)
        errors = []
        errors.push("payment_id must be present.") unless data.key?("payment_id")
        errors.push("payment_id must be a Monero Payment ID.") unless MoneroPaymentID.valid?(data["payment_id"])
        errors
      end
    end
  end
end
