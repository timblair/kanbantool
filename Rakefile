require "bundler/gem_tasks"

task :test do
  Dir.glob('./spec/**/*_spec.rb') { |f| require f }
end

task :default => :test
