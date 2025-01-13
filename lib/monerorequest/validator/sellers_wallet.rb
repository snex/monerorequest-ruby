# frozen_string_literal: true

module Monerorequest
  module Validator
    # validates the sellers_wallet field
    class SellersWallet
      def self.validate!(data)
        errors = []
        errors.push("sellers_wallet must be present.") unless data.key?("sellers_wallet")
        return errors if MoneroAddress.valid?(data["sellers_wallet"])

        errors.push("sellers_wallet must be a main Monero address.")
        errors
      end
    end
  end
end
