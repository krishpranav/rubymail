$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
require 'simplecov'
SimpleCov.start

require "rspec"
require "pry"
require "rubymail"

RSpec.configure do |config|
end