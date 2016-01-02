module CsoundAPIRuby
  module Lib
    module Functions
      PATH = File.expand_path(File.join('..', 'functions'), __FILE__)
    end
  end
end

%w(
  header
  csoundCreate
  csoundCompile
  csoundCompileArgs
  csoundCompileCsd
  csoundCompileOrc
  csoundPerformKsmps
  csoundPerform
  csoundPerformBuffer
  csoundStart
  csoundStop
  csoundCleanup
  csoundDestroy
  csoundReset
  csoundGetSr
  csoundGetKr
  csoundGetKsmps
  csoundGetNchnls
  csoundGetNchnlsInput
  csoundGet0dBFS
  csoundGetCurrentTimeSamples
  csoundGetSizeOfMYFLT
  csoundGetHostData
  csoundSetHostData
  csoundSetOption
  csoundGetDebug
  csoundSetDebug
  csoundGetParams
  csoundSetParams
).each { |f| require File.join(CsoundAPIRuby::Lib::Functions::PATH, f) }
