$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start

require 'active_record'
require 'wisperable'

require_relative 'support/database/schema.rb'