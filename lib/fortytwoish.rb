require 'fortytwoish/version'
require 'fortytwoish/client'
require 'fortytwoish/configuration'

module Fortytwoish
  class FortytwoRuntimeError < StandardError; end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset_configuration
    @configuration = nil
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
