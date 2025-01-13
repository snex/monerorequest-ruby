# frozen_string_literal: true

require "json"

module Monerorequest
  module Pipeline
    # pipeline that takes a JSON string and converts it into a ruby object
    class JSONParser
      def self.call(input)
        JSON.parse(input)
      end
    end
  end
end
