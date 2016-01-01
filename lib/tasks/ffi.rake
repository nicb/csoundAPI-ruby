namespace :FFI do
  namespace :struct do

    require 'ffi'
    require 'ffi/tools/generator'
    require 'ffi/tools/struct_generator'
    require 'bundler/setup'

    EXT_INCLUDE_CSOUND_PATH = File.expand_path(File.join(['..'] * 3, 'ext', 'csound', 'include'), __FILE__)
    EXT_INCLUDE_CS6MAKE_PATH = File.expand_path(File.join(['..'] * 3, 'ext', 'cs6make', 'include'), __FILE__)
    FFI_DATA_PATH = File.expand_path(File.join(['..'] * 3, 'lib', 'csoundAPI_ruby', 'lib', 'data'), __FILE__)
    FFI_DATA_FILES = Dir.glob(File.join(FFI_DATA_PATH, '**', '*.ffi'))
    FFI_OPTIONS = { :cflags => "-I#{EXT_INCLUDE_CSOUND_PATH} -I#{EXT_INCLUDE_CS6MAKE_PATH}" }

    desc 'generate data structures'
    task :generate do
      FFI_DATA_FILES.each do
        |ffi_file|
        ruby_file = ffi_file.gsub(/\.ffi$/,'')
        unless uptodate?(ruby_file, [ ffi_file ])
          puts "--- generating: #{File.basename(ffi_file)} => #{File.basename(ruby_file)}"
          require File.join(FFI_DATA_PATH, 'header')
          FFI::Generator.new ffi_file, ruby_file, FFI_OPTIONS
        end
      end
    end

  end
end
