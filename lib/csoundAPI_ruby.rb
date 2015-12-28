module CsoundAPIRuby

  PATH = File.expand_path(File.join('..', 'csoundAPI_ruby'), __FILE__)

end

%w(
  version
  lib
).each { |f| require File.join(CsoundAPIRuby::PATH, f) }
