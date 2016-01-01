module Spec
  module Utilities

    def quiet_stderr
      stderr_backup = $stderr.dup
      $stderr.reopen('/dev/null', 'w')
    
      yield
    
    ensure
      $stderr.reopen(stderr_backup)
    end

  end
end
