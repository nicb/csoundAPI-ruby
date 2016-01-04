module Spec
  module Utilities

    def fixture_syscall(command_line)
      res = nil
      env = ENV.to_hash
      env.update('LD_LIBRARY_PATH' =>  "#{CsoundAPIRuby::Lib::Functions::CSOUND_LIBRARY_PATH}")
      IO::popen([env, command_line], 'r') do
        |handle|
        value = handle.gets.chomp.to_i
        res = value
        yield(res) if block_given?
      end
      res
    end

  end
end
