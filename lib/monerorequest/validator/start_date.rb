# frozen_string_literal: true

require "date"

module Monerorequest
  module Validator
    # validates the start_date field
    class StartDate
      def self.validate!(data)
        errors = []
        errors.push("start_date must be present.") unless data.key?("start_date")
        errors.push("start_date must be a String.") && data["start_date"] = "" unless data["start_date"].is_a?(String)
        begin
          DateTime.rfc3339(data["start_date"])
        rescue Date::Error
          errors.push("start_date must be an RFC3339 timestamp.")
        end
        errors
      end
    end
  end
end
