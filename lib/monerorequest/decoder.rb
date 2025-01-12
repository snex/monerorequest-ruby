# frozen_string_literal: true

require_relative "v1"
require_relative "v2"

module Monerorequest
  # class to choose a proper Decoder Version and then pass the encoded data to it for decoding
  class Decoder
    attr_reader :errors

    def initialize(request)
      @request = request
      _, @version, @encoded_str = @request.split(":")
      @decoder = case @version.to_i
                 when 1
                   V1
                 when 2
                   V2
                 else
                   raise RequestVersionError, "Unknown version: #{@version}. Only 1 and 2 are supported."
                 end
    end

    def decode
      @data = @encoded_str

      @decoder::Decoder::PIPELINES.each do |pipeline|
        @data = pipeline.call(@data)
      end

      @data["version"] = @version.to_i
      validate!
      @data
    end

    private

    def validate!
      @errors = []
      @decoder::VALIDATORS.each do |validator|
        @errors += validator.validate!(@data)
      end

      raise InvalidRequestError, "Invalid request: #{@errors}" unless @errors.empty?
    end
  end
end
