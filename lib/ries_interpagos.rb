require "ries_interpagos/version"
require "ries_interpagos/configuration"
require "ries_interpagos/message"
require "ries_interpagos/client"

module RiesInterpagos
  class << self
    attr_accessor :configuration
  end

  def self.configure
     self.configuration ||= Configuration.new
     yield(configuration)
  end

  def self.create_message
    msg = Message.new(self.configuration)
    yield(msg)
    msg
  end

  def self.create_client(msg)
    client = Client.new(self.configuration, msg)
    client
  end
end
