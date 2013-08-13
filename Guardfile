guard :bundler do
	watch('Gemfile')
	watch(%r{^.+\.gemspec$})
end

guard :yard, stdout: '/dev/null', stderr: '/dev/null' do
  watch(%r{lib/.+\.rb})
  watch('README.md')
  watch('LICENSE')
  watch('.yardopts')
end

guard :cucumber, rvm: ['1.9.3@magus', '2.0.0@magus'], cli: '--profile guard', run_all: {cli: "--profile all"}, all_on_start: true, all_after_pass: false  do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end

guard :rspec, rvm: ['1.9.3@magus', '2.0.0@magus'], run_all: {cli: '--format Fuubar --order random'}, all_on_start: true, all_after_pass: false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/support/.+\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

