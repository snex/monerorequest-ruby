# frozen_string_literal: true

module Monerorequest
  module Validator
    # validates the schedule field
    class Schedule
      def self.validate!(data)
        errors = []
        errors.push("schedule must be present.") unless data.key?("schedule")
        errors.push("schedule must be a valid Cron.") unless Cron.valid?(data.fetch("schedule", ""))
        errors
      end
    end
  end
end
