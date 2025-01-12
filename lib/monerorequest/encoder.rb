# frozen_string_literal: true

require_relative "v1"
require_relative "v2"

module Monerorequest
  # class to Encode a Monerorequest hash
  class Encoder
    attr_reader :errors

    def initialize(request, version)
      unless [1, 2].include?(version.to_i)
        raise RequestVersionError, "Unknown version: #{version}. Only 1 and 2 are supported."
      end

      @request = request
      @version = version.to_i
      set_encoder_version
      @errors = []
      validate!
    end

    def encode
      data = @request

      @encoder::Encoder::PIPELINES.each do |pipeline|
        data = pipeline.call(data)
      end

      "monero-request:#{@version}:#{data}"
    end

    private

    def set_encoder_version
      @encoder = case @version
                 when 1
                   V1
                 when 2
                   V2
                 else
                   raise RequestVersionError, "Unknown version: #{@version}. Only 1 and 2 are supported."
                 end
    end

    def validate!
      @encoder::VALIDATORS.each do |validator|
        @errors += validator.validate!(@request)
      end

      raise InvalidRequestError, "Invalid request: #{@errors}" unless @errors.empty?
    end
  end
end
