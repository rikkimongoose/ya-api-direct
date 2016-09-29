require "bundler/gem_tasks"
require "rake/testtask"

task :spec do
  Dir.glob('./spec/**/spec_*.rb').each { |file| require file}
end

task test: [:spec]
task default: [:spec]