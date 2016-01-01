namespace :fixtures do
  namespace :C do

    C_FIXTURE_PATH = File.expand_path(File.join(['..'] * 3, 'spec', 'fixtures', 'C'), __FILE__)

    desc 'build the C library fixture'
    task :build do
       env = ENV['TRAVIS_OS_NAME'] ? ENV['TRAVIS_OS_NAME'] : 'linux'
       cd(C_FIXTURE_PATH) { sh "make OS_NAME=#{env}" }
    end

    desc 'cleanup the C library fixture'
    task :clean do
      cd(C_FIXTURE_PATH) { sh 'make clean' }
    end

  end
end
