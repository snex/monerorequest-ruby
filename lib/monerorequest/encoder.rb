# frozen_string_literal: true

Monerorequest::SUPPORTED_MR_VERSIONS.each do |mr_v|
  require_relative "v#{mr_v}"
end

module Monerorequest
  # class to Encode a Monerorequest hash
  class Encoder
    attr_reader :errors

    def initialize(request, version)
      unless Monerorequest::SUPPORTED_MR_VERSIONS.include?(version.to_i)
        raise RequestVersionError.new(version)
      end

      @request = request
      @version = version.to_i
      set_encoder_version
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
      @encoder = Object.const_get("Monerorequest::V#{@version}")
    end

    def validate!
      @errors = []
      @encoder::VALIDATORS.each do |validator|
        @errors += validator.validate!(@request)
      end

      raise InvalidRequestError, "Invalid request: #{@errors}" unless @errors.empty?
    end
  end
end
