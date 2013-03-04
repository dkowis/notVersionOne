# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# load up the java jars
require 'java'
Dir["#{File.expand_path("../../lib/jars", __FILE__)}/*.jar"].each do |jar|
  require jar
end
