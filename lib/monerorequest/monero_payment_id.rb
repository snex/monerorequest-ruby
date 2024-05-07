# frozen_string_literal: true

module Monerorequest
  # provide a validator for a Monero Payment ID
  class MoneroPaymentID
    def self.valid?(payment_id)
      return false unless payment_id.is_a?(String)
      return false unless payment_id.length == 16
      return false unless payment_id =~ /[0-9a-f]/

      true
    end
  end
end
