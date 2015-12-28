module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundCleanup, [:pointer], :void

    end

  end

end
