if RUBY_VERSION.to_f >= 1.9 && RUBY_ENGINE == 'ruby'
  require 'simplecov'

  SimpleCov.start do
    add_filter "/spec"
    add_filter "/features"
    add_filter "/doc"
    add_filter "/tmp"
    add_filter "/.yardoc"
  end
end

