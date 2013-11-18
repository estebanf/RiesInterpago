module RiesInterpagos
  class Message
    attr_accessor :reference, :total_amount, :request_date
    attr_reader :api_key, :id_cliente, :pin
    def initialize(config)
      @api_key = config.api_key
      @id_cliente = config.id_cliente
      @pin = config.pin
    end
  end
end