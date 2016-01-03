module Spec
  module Utilities

    def fixture_syscall(command_line)
      ENV['LD_LIBRARY_PATH'] = "#{CsoundAPIRuby::Lib::Functions::CSOUND_LIBRARY_PATH}" 
      handle = IO::popen(command_line, 'r')
      value = handle.gets.chomp.to_i
      res = value
      yield(res) if block_given?
      res
    end

  end
end
