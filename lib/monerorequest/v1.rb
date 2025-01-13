# frozen_string_literal: true

require_relative "pipeline/base64_decoder"
require_relative "pipeline/base64_encoder"
require_relative "pipeline/gzip_reader"
require_relative "pipeline/gzip_writer"
require_relative "pipeline/json_parser"
require_relative "pipeline/json_encoder"
require_relative "validator/custom_label"
require_relative "validator/sellers_wallet"
require_relative "validator/currency"
require_relative "validator/amount"
require_relative "validator/payment_id"
require_relative "validator/start_date"
require_relative "validator/days_per_billing_cycle"
require_relative "validator/number_of_payments"
require_relative "validator/change_indicator_url"

module Monerorequest
  module V1
    VALIDATORS = [
      Monerorequest::Validator::CustomLabel,
      Monerorequest::Validator::SellersWallet,
      Monerorequest::Validator::Currency,
      Monerorequest::Validator::Amount,
      Monerorequest::Validator::PaymentID,
      Monerorequest::Validator::StartDate,
      Monerorequest::Validator::DaysPerBillingCycle,
      Monerorequest::Validator::NumberOfPayments,
      Monerorequest::Validator::ChangeIndicatorURL
    ].freeze

    module Encoder
      PIPELINES = [
        Monerorequest::Pipeline::JSONEncoder,
        Monerorequest::Pipeline::GzipWriter,
        Monerorequest::Pipeline::Base64Encoder
      ].freeze
    end

    module Decoder
      PIPELINES = [
        Monerorequest::Pipeline::Base64Decoder,
        Monerorequest::Pipeline::GzipReader,
        Monerorequest::Pipeline::JSONParser
      ].freeze
    end
  end
end
