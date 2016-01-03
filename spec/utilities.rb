module Spec
  module Utilities

    PATH = File.expand_path(File.join('..', 'utilities'), __FILE__)

  end
end

%w(
  quiet_stderr
  csound
  fixture_syscall
).each { |f| require File.join(Spec::Utilities::PATH, f) }
