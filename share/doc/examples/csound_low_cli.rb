#!/usr/bin/env ruby
#
# csound_low_cli.rb: this is a command-line interface command that replicates
# the regular 'C' +csound+ command line.
#
require 'bundler/setup'
require 'csoundAPI_ruby'
require 'FFI/utilities'

include CsoundAPIRuby::Lib::Functions

cs = csoundCreate(nil)
argv = [$0] + ARGV # ARGV does not have argv[0] as in C, so we need to add it in front
res = csoundCompile(cs, argv.size, FFI::Utilities.set_argv(argv))
csoundPerform(cs)
csoundCleanup(cs)
csoundDestroy(cs)

exit(res)
