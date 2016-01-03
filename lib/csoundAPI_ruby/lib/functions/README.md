# Implemented API functions

Within the module `CsoundAPIRuby::Lib::Functions`:

[instantiation functions](https://csound.github.io/docs/api/group__INSTANTIATION.html)

* `csoundCreate, [:pointer], :pointer`
* `csoundCompile, [:pointer, :int, :pointer], :int`
* `csoundCompileArgs, [:pointer, :int, :pointer], :int`
* `csoundCompileCsd, [:pointer, :pointer], :int`
* `csoundCompileOrc, [:pointer, :pointer], :int`
* `csoundGetVersion, [], :int`
* `csoundGetAPIVersion, [], :int`

[perform functions](https://csound.github.io/docs/api/group__PERFORMANCE.html)

* `csoundPerformKsmps, [:pointer], :int`
* `csoundPerform, [:pointer], :int`
* `csoundPerformBuffer, [:pointer], :int`
* `csoundStart, [:pointer], :int`
* `csoundStop, [:pointer], :void`

cleanup functions

* `csoundCleanup, [:pointer], :void`
* `csoundDestroy, [:pointer], :void`
* `csoundReset, [:pointer], :void`

[attribute functions](://csound.github.io/docs/api/group__ATTRIBUTES.html) 

* `csoundGetSr, [:pointer], :double`
* `csoundGetKr, [:pointer], :double`
* `csoundGetKsmps, [:pointer], :uint32`
* `csoundGetNchnls, [:pointer], :uint32`
* `csoundGetNchnlsInput, [:pointer], :uint32`
* `csoundGet0dBFS, [:pointer], :double`
* `csoundGetCurrentTimeSamples, [:pointer], :int64`
* `csoundGetSizeOfMYFLT, [:pointer], :int`
* `csoundGetHostData, [:pointer], :pointer`
* `csoundSetHostData, [:pointer, :pointer], :void`
* `csoundSetOption, [:pointer, :pointer], :int`
* `csoundGetDebug, [:pointer], :int`
* `csoundSetDebug, [:pointer, :int], :void`
* `csoundSetParams, [:pointer, CsoundAPIRuby::Lib::Data::CsoundParams.by_ref], :void`
* `csoundGetParams, [:pointer, CsoundAPIRuby::Lib::Data::CsoundParams.by_ref], :void`
