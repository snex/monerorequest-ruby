# frozen_string_literal: true


Monerorequest::SUPPORTED_MR_VERSIONS.each do |mr_v|
  require_relative "v#{mr_v}"
end

module Monerorequest
  # class to choose a proper Decoder Version and then pass the encoded data to it for decoding
  class Decoder
    attr_reader :errors

    def initialize(request)
      @request = request
      _, @version, @encoded_str = @request.split(":")
      unless Monerorequest::SUPPORTED_MR_VERSIONS.include?(@version.to_i)
        raise RequestVersionError.new(@version)
      end

      @decoder = Object.const_get("Monerorequest::V#{@version}")
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
