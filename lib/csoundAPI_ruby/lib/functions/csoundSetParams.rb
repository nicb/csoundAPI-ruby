require_relative File.join('..', 'data', 'csound_params')

module CsoundAPIRuby

  module Lib

    module Functions

      extend FFI::Library
  
      attach_function :csoundSetParams, [:pointer, CsoundAPIRuby::Lib::Data::CsoundParams.by_ref], :void

    end

  end

end
