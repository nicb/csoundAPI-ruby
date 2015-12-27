# Ruby bindings to the Csound API

[![Join the chat at https://gitter.im/nicb/csoundAPI-ruby](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/nicb/csoundAPI-ruby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.org/nicb/csoundAPI-ruby.svg?branch=master)](https://travis-ci.org/nicb/csoundAPI-ruby)
[![Code Climate](https://codeclimate.com/github/nicb/csoundAPI-ruby/badges/gpa.svg)](https://codeclimate.com/github/nicb/csoundAPI-ruby)
[![Test Coverage](https://codeclimate.com/github/nicb/csoundAPI-ruby/badges/coverage.svg)](https://codeclimate.com/github/nicb/csoundAPI-ruby/coverage)
[![Issue Count](https://codeclimate.com/github/nicb/csoundAPI-ruby/badges/issue_count.svg)](https://codeclimate.com/github/nicb/csoundAPI-ruby)

This is a Ruby binding gem to the csound sound software compiler API using FFI.

I wish somebody else had done it, so that I did not have to do it. However, so
far nobody has undertaken this task, so I'll give it a try.

## Requirements

Some applications are required to compile the `csound` library:

* [`make`](https://www.gnu.org/software/make/)
* [`cmake`](https://cmake.org/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csoundAPI-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csoundAPI-ruby

After you have installed the `csoundAPI-ruby` gem, you **have to** run the
following command:

    $ bundle exec rake csound:build

which will compile the `csound` library for you.

## Usage

We already got the basic command line working. You can write
something like:

```ruby
#!/usr/bin/env ruby
#
# csound_low_cli.rb: this is a command-line interface command that replicates
# the regular 'C' +csound+ command line.
#
require 'bundler/setup'
require 'csoundAPI_ruby'
require 'FFI/utilities'

include CsoundAPIRuby::CsoundLib

cs = csoundCreate(nil)
argv = [$0] + ARGV # ARGV does not have argv[0] as in C, so we need to add it in front
res = csoundCompile(cs, argv.size, FFI::Utilities.set_argv(argv))
csoundPerform(cs)
csoundCleanup(cs)
csoundDestroy(cs)

exit(res)
```
(you can find this snippet [here](./share/doc/examples/csound_low_cli.rb)). Then you
can run from a terminal:

```sh
$ ./share/doc/examples/csound_low_cli.rb -dWo ./test.wav spec/fixtures/csound/simple.csd
```

and this will produce the same result as if you called csound from the usual
`C` command.

### Implemented API

* `CsoundAPIRuby::CsoundLib::csoundCreate, [:pointer], :pointer`
* `CsoundAPIRuby::CsoundLib::csoundCompile, [:pointer, :int, :pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundCompileArgs, [:pointer, :int, :pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundCompileCsd, [:pointer, :pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundCompileOrc, [:pointer, :pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundPerformKsmps, [:pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundPerform, [:pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundPerformBuffer, [:pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundStart, [:pointer], :int`
* `CsoundAPIRuby::CsoundLib::csoundStop, [:pointer], :void`
* `CsoundAPIRuby::CsoundLib::csoundCleanup, [:pointer], :void`
* `CsoundAPIRuby::CsoundLib::csoundDestroy, [:pointer], :void`
* `CsoundAPIRuby::CsoundLib::csoundReset, [:pointer], :void`
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

## Help Wanted

**HELP WANTED** and most welcome.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/csoundAPI-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

  CsoundAPI-ruby
  Copyright (C) 2015 Nicola Bernardini
  Licensed under the terms of the GNU GPL version 2 License

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License along
  with this program; if not, write to the Free Software Foundation, Inc.,
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
