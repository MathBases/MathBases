require 'rake'

desc "Run all validation tests"
task :test do
  puts "Running MathBases validation tests..."
  sh "ruby test_validation.rb"
end

desc "Run only YAML validation (skip Jekyll build test)"
task :test_yaml do
  puts "Running YAML validation tests..."
  # Run the validator without the Jekyll build test
  ruby_code = %q{
    load 'test_validation.rb'
    validator = DatabaseValidator.new
    validator.validate_all_databases
    puts '🎉 YAML validation completed!'
  }
  sh "ruby", "-e", ruby_code
end

desc "Run Jekyll build test"
task :test_build do
  puts "Testing Jekyll build..."
  ENV['PATH'] = "#{ENV['HOME']}/.local/share/gem/ruby/3.2.0/bin:#{ENV['PATH']}"
  ENV['GEM_HOME'] = "#{ENV['HOME']}/.gem"
  
  sh "bundle exec jekyll build --config _config.yml,_config.local.yml --quiet"
  puts "✅ Jekyll build test passed"
end

desc "Set up test environment (install dependencies)"
task :setup do
  puts "Setting up test environment..."
  sh "gem install bundler --user-install"
  
  ENV['PATH'] = "#{ENV['HOME']}/.local/share/gem/ruby/3.2.0/bin:#{ENV['PATH']}"
  ENV['GEM_HOME'] = "#{ENV['HOME']}/.gem"
  
  sh "bundle install"
  puts "✅ Test environment ready"
end

task :default => :test