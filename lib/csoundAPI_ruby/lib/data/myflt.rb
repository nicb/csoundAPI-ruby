module CsoundAPIRuby
  module Lib
    module Data

      extend FFI::Library

      if FFI::Platform.bsd? || FFI::Platform.mac? || FFI::Platform.unix?
        MYFLT = FFI.typedef :double, :MYFLT
      elsif FFI::Platform.windows?
        MYFLT = FFI.typedef :float, :MYFLT
      else
        raise StandardError, "unknown FFI::Platform"
      end

    end
  end
end
