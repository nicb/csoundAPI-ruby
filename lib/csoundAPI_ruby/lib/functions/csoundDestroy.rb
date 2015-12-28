module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundDestroy, [:pointer], :void

    end

  end

end
