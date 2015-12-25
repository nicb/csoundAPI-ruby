require 'csoundAPI_ruby'
require 'FFI_ext'

cs = FFI::CsoundLib::csoundCreate(nil)
result = FFI::CsoundLib::csoundCompile(cs, ARGV.size, FFIExt::Utilities.argv(ARGV))
