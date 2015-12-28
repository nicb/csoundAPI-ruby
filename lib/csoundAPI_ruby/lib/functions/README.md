# Implemented API functions

[instantiation functions](https://csound.github.io/docs/api/group__INSTANTIATION.html)

* `CsoundAPIRuby::CsoundLib::csoundCreate, [:pointer], :pointer`
* `CsoundAPIRuby::CsoundLib::csoundCompile, [:pointer, :int, :pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundCompileArgs, [:pointer, :int, :pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundCompileCsd, [:pointer, :pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundCompileOrc, [:pointer, :pointer], :int`

[perform functions](https://csound.github.io/docs/api/group__PERFORMANCE.html)

* `CsoundAPIRuby::CsoundLib::csoundPerformKsmps, [:pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundPerform, [:pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundPerformBuffer, [:pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundStart, [:pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundStop, [:pointer], :void`

cleanup functions

* `CsoundAPIRuby::CsoundLib::csoundCleanup, [:pointer], :void`
* `CsoundAPIRuby::CsoundLib::csoundDestroy, [:pointer], :void`
* `CsoundAPIRuby::CsoundLib::csoundReset, [:pointer], :void`

[attribute functions](://csound.github.io/docs/api/group__ATTRIBUTES.html) 

* `CsoundAPIRuby::CsoundLib::csoundGetSr, [:pointer], :double`
* `CsoundAPIRuby::CsoundLib::csoundGetKr, [:pointer], :double`
* `CsoundAPIRuby::CsoundLib::csoundGetKsmps, [:pointer], :uint32`
* `CsoundAPIRuby::CsoundLib::csoundGetNchnls, [:pointer], :uint32`
* `CsoundAPIRuby::CsoundLib::csoundGetNchnlsInput, [:pointer], :uint32`
* `CsoundAPIRuby::CsoundLib::csoundGet0dBFS, [:pointer], :double`
* `CsoundAPIRuby::CsoundLib::csoundGetCurrentTimeSamples, [:pointer], :int64`
* `CsoundAPIRuby::CsoundLib::csoundGetSizeOfMYFLT, [:pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundGetHostData, [:pointer], :pointer`
* `CsoundAPIRuby::CsoundLib::csoundSetHostData, [:pointer, :pointer], :void`
* `CsoundAPIRuby::CsoundLib::csoundSetOption, [:pointer, :pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundGetDebug, [:pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundSetDebug, [:pointer, :int], :void`
