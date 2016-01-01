namespace :fixtures do
  namespace :C do

    C_FIXTURE_PATH = File.expand_path(File.join(['..'] * 3, 'spec', 'fixtures', 'C'), __FILE__)

    desc 'build the C library fixture'
    task :build do
      cd(C_FIXTURE_PATH) { sh "make OS_NAME=#{guess_platform}" }
    end

    desc 'cleanup the C library fixture'
    task :clean do
      cd(C_FIXTURE_PATH) { sh "make OS_NAME=\"#{guess_platform}\" clean" }
    end

    def guess_platform
       res = ENV['TRAVIS_OS_NAME']
       unless res
         res = case RUBY_PLATFORM
           when /linux/ then 'linux'
           when /darwin/ then 'osx'
           else raise StandardError, "unknown platform #{RUBY_PLATFORM}: you can add one at #{__FILE__}:#{__LINE__-1}"
         end
       end
       res
    end

  end
end
