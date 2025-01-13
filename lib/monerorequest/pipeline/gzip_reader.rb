# frozen_string_literal: true

require "stringio"
require "zlib"

module Monerorequest
  module Pipeline
    # pipeline that takes a gzip blob and unzips it
    class GzipReader
      def self.call(input)
        Zlib::GzipReader.new(StringIO.new(input)).read
      end
    end
  end
end
