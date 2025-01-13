# frozen_string_literal: true

module Monerorequest
  module Validator
    # validates the custom_label field
    class CustomLabel
      def self.validate!(data)
        errors = []
        errors.push("custom_label must be present.") unless data.key?("custom_label")
        errors.push("custom_label must be a String.") unless data["custom_label"].is_a?(String)
        errors
      end
    end
  end
end
