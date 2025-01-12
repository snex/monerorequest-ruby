# frozen_string_literal: true

module Monerorequest
  # Parses and validates cron syntax string.
  class Cron
    MONTH_CODES = %w[jan feb mar apr may jun jul aug sep oct nov dec].freeze
    DOW_CODES = %w[mon tue wed thu fri sat sun].freeze
    DELIMITERS = %r{,|-|/}.freeze
    def self.valid?(schedule)
      parsed_schedule = parse(schedule)
      return false unless parsed_schedule

      valid_minutes?(parsed_schedule["minutes"]) && valid_hours?(parsed_schedule["hours"]) &&
        valid_days?(parsed_schedule["days"]) && valid_months?(parsed_schedule["months"]) &&
        valid_dow?(parsed_schedule["dow"])
    end

    def self.valid_minutes?(minutes)
      minutes.all? { |min| ("0".."59").member?(min.to_s) } || minutes == ["*"]
    end

    def self.valid_hours?(hours)
      hours.all? { |hr| ("0".."23").member?(hr.to_s) } || hours == ["*"]
    end

    def self.valid_days?(days)
      days.all? { |dy| ("1".."31").member?(dy.to_s) } || days == ["*"]
    end

    def self.valid_months?(months)
      months.all? do |mth|
        ("1".."12").member?(mth.to_s) || MONTH_CODES.include?(mth.to_s.downcase)
      end || months == ["*"] || months == ["L"]
    end

    def self.valid_dow?(dow)
      dow.all? { |d| DOW_CODES.include?(d.downcase) } || dow == ["*"]
    end

    def self.parse(schedule)
      schedule_parts = schedule.split
      return false if schedule_parts.length != 5

      {
        "minutes" => schedule_parts[0].split(DELIMITERS),
        "hours" => schedule_parts[1].split(DELIMITERS),
        "days" => schedule_parts[2].split(DELIMITERS),
        "months" => schedule_parts[3].split(DELIMITERS),
        "dow" => schedule_parts[4].split(DELIMITERS)
      }
    end
  end
end
