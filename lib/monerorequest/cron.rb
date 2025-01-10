# frozen_string_literal: true

module Monerorequest
  class Cron
    MONTH_CODES = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec']
    DOW_CODES = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
    DELIMITERS = /,|-|\//
    def self.valid?(schedule)
      parsed_schedule = self.parse(schedule)
      return false if not parsed_schedule

      return self.valid_minutes?(parsed_schedule['minutes']) && self.valid_hours?(parsed_schedule['hours']) &&
             self.valid_days?(parsed_schedule['days']) && self.valid_months?(parsed_schedule['months'])
             self.valid_dow?(parsed_schedule['dow'])
    end

    def self.valid_minutes?(minutes)
      return minutes.all? { |min| ('0'..'59').member?(min) } || minutes == ["*"]
    end

    def self.valid_hours?(hours)
      return hours.all?{ |hr| ('0'..'23').member?(hr) } || hours == ["*"]
    end

    def self.valid_days?(days)
      return days.all?{ |dy| (1..31).member?(dy.to_i) } || days == ["*"]
    end

    def self.valid_months?(months)
      return months.all?{ |mth| (1..12).member?(mth.to_i) || MONTH_CODES.include?(mth.downcase) } || months == ["*"]
    end

    def self.valid_dow?(dow)
      return dow.all?{ |d| DOW_CODES.include?(d.downcase) } || dow == ["*"]
    end

    def self.parse(schedule)
      schedule_parts = schedule.split(' ')
      return false if schedule_parts.length != 5
      parsed_schedule = {}
      parsed_schedule['minutes'] = schedule_parts[0].split(DELIMITERS)
      parsed_schedule['hours'] = schedule_parts[1].split(DELIMITERS)
      parsed_schedule['days'] = schedule_parts[2].split(DELIMITERS)
      parsed_schedule['months'] = schedule_parts[3].split(DELIMITERS)
      parsed_schedule['dow'] = schedule_parts[4].split(DELIMITERS)

      return parsed_schedule
    end
  end
end