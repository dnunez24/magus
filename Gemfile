source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'yard'
  gem 'redcarpet'
  gem 'guard-yard'
  gem 'guard-bundler'

  case RUBY_PLATFORM
  when /darwin/i
    gem 'terminal-notifier-guard', require: false
  when /linux/i
    gem 'libnotify', require: false
  when /mswin|mingw/i
    gem 'win32console', require: false
    gem 'rb-notifu', require: false
  end
end

group :test do
  gem 'rspec'
  gem 'cucumber'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'simplecov', :require => false
end