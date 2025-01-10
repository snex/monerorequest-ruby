# frozen_string_literal: true

require "base64"
require "date"
require "json"
require "stringio"
require "uri"
require "zlib"

module Monerorequest
  # class to Encode a Monerorequest hash
  class Encoder
    class InvalidRequest < StandardError; end

    attr_accessor :request
    attr_reader :errors

    def initialize(request)
      @request = request
      @errors = []

      validate!
    end

    def encode(version)
      raise RequestVersionError, "Request Versions 1 and 2 are supported." unless [1,2].include?(version.to_i)

      json_str = @request.sort.to_h.to_json.force_encoding("ascii")
      compressed_data = StringIO.new
      gz = Zlib::GzipWriter.new(compressed_data, 9)
      gz.mtime = 0
      gz.write(json_str)
      gz.close
      encoded_str = Base64.encode64(compressed_data.string).gsub("\n", "")
      "monero-request:#{version}:#{encoded_str}"
    end

    private

    def validate!
      validate_custom_label!
      validate_sellers_wallet!
      validate_currency!
      validate_amount!
      validate_payment_id!
      validate_start_date!
      if @request["version"] == 1 then
        validate_days_per_billing_cycle!
      end
      if @request["version"] == 2 then
        validate_schedule!
      end
      validate_change_indicator_url!
    end

    def validate_custom_label!
      @errors.push("custom_label must be present.") unless @request.key?("custom_label")
      @errors.push("custom_label must be a String.") unless @request["custom_label"].is_a?(String)
    end

    def validate_sellers_wallet!
      @errors.push("sellers_wallet must be present.") unless @request.key?("sellers_wallet")
      return if MoneroAddress.valid?(@request["sellers_wallet"])

      @errors.push("sellers_wallet must be a main Monero address.")
    end

    def validate_currency!
      @errors.push("currency must be present.") unless @request.key?("currency")
      @errors.push("currency must be a String.") unless @request["currency"].is_a?(String)
    end

    def validate_amount!
      @errors.push("amount must be present.") unless @request.key?("amount")
      @errors.push("amount must be a Numeric.") unless @request["amount"].is_a?(Numeric)
    end

    def validate_payment_id!
      @errors.push("payment_id must be present.") unless @request.key?("payment_id")
      @errors.push("payment_id must be a Monero Payment ID.") unless MoneroPaymentID.valid?(@request["payment_id"])
    end

    def validate_start_date!
      @errors.push("start_date must be present.") unless @request.key?("start_date")
      unless @request["start_date"].is_a?(String)
        @errors.push("start_date must be a String.") && @request["start_date"] = ""
      end
      begin
        DateTime.rfc3339(@request["start_date"])
      rescue Date::Error
        @errors.push("start_date must be an RFC3339 timestamp.")
      end
    end

    def validate_days_per_billing_cycle!
      @errors.push("days_per_billing_cycle must be present.") unless @request.key?("days_per_billing_cycle") && @request["version"] == '1'
      @errors.push("days_per_billing_cycle must be a Integer.") unless @request["days_per_billing_cycle"].is_a?(Integer)
    end

    def validate_change_indicator_url!
      @errors.push("change_indicator_url must be present.") unless @request.key?("change_indicator_url")
      unless @request["change_indicator_url"].is_a?(String)
        @errors.push("change_indicator_url must be a String.") && @request["change_indicator_url"] = ""
      end
      return if @request["change_indicator_url"] =~ URI::DEFAULT_PARSER.make_regexp

      @errors.push("change_indicator_url must be a URL.")
    end

    def validate_schedule!
      @errors.push("schedule must be present.") unless @request.key?("schedule")
      @errors.push("schedule must be a valid Cron.") unless Cron.valid?(@request.fetch("schedule", ""))
    end
  end
end
