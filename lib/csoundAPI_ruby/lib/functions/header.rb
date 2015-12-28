require 'ffi'

module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library

      LIBRARY_SUFFIX = case RUBY_PLATFORM
                       when /linux/i then '.so'
                       when /darwin/i then '.dylib'
                       when /windows/i then '.dll'
                       else raise StandardError, "Unknown platform #{RUBY_PLATFORM}"
                       end
      CSOUND_LIBRARY_PATH = File.expand_path(File.join(['..'] * 5, 'ext', 'cs6make', "libcsnd6#{LIBRARY_SUFFIX}"), __FILE__)
      ffi_lib CSOUND_LIBRARY_PATH

    end

  end

end
