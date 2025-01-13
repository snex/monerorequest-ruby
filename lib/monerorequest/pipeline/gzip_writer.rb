# frozen_string_literal: true

require "stringio"
require "zlib"

module Monerorequest
  module Pipeline
    # pipeline that takes a string and gzips it
    class GzipWriter
      def self.call(input)
        output = StringIO.new
        gz = Zlib::GzipWriter.new(output, 9)
        gz.mtime = 0
        gz.write(input)
        gz.close
        output.string
      end
    end
  end
end
