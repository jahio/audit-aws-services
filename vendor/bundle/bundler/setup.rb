require 'rbconfig'
# ruby 1.8.7 doesn't define RUBY_ENGINE
ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
ruby_version = RbConfig::CONFIG["ruby_version"]
path = File.expand_path('..', __FILE__)
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/json_pure-1.8.3/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/jmespath-1.2.4/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/aws-sdk-core-2.3.11/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/aws-sdk-resources-2.3.11/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/aws-sdk-2.3.11/lib"
$:.unshift "#{path}/"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/thor-0.19.1/lib"
