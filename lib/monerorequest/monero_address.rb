# frozen_string_literal: true

module Monerorequest
  # provide a validator for a Monero main address
  class MoneroAddress
    def self.valid?(address)
      return false unless address.is_a?(String)
      return false unless address[0] == "4"
      return false unless address[1] =~ /[0-9AB]/
      return false unless address.length == 95

      true
    end
  end
end
