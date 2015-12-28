module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundReset, [:pointer], :void

    end

  end

end
