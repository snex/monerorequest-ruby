# frozen_string_literal: true

module Monerorequest
  SUPPORTED_MR_VERSIONS = [1, 2].freeze

  class RequestVersionError < StandardError
    def initialize(version)
      @version = version
    end

    def message
      "Unknown version: #{@version}. Allowed versions: #{Monerorequest::SUPPORTED_MR_VERSIONS}"
    end
  end
  class InvalidRequestError < StandardError; end
end

require_relative "monerorequest/decoder"
require_relative "monerorequest/encoder"
require_relative "monerorequest/monero_address"
require_relative "monerorequest/monero_payment_id"
require_relative "monerorequest/version"
require_relative "monerorequest/cron"
