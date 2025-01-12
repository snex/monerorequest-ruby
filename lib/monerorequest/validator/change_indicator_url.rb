# frozen_string_literal: true

require "uri"

module Monerorequest
  module Validator
    # validates the change_indicator_url field
    class ChangeIndicatorURL
      def self.validate!(data)
        return [] unless data.key?("change_indicator_url")

        errors = []
        unless data["change_indicator_url"].is_a?(String)
          errors.push("change_indicator_url must be a String.")
          data["change_indicator_url"] = ""
        end
        return errors if data["change_indicator_url"] =~ URI::DEFAULT_PARSER.make_regexp

        errors.push("change_indicator_url must be a URL.")
        errors
      end
    end
  end
end
