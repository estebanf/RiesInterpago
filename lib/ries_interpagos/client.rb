require 'digest/sha1'
require 'savon'

module RiesInterpagos
  class Client
    attr_reader :ws_response,:data_message,:service_client,:request_apikey, :request_idclient, :request_idreference,:request_token, :request_totalamount, :request_date
    def initialize(config,message)
      @request_idclient = config.id_cliente
      @request_apikey = config.api_key
      @request_idreference = message.reference
      @request_totalamount = sprintf("%.2f",message.total_amount.to_f.round(2))
      @request_date = message.request_date
      @request_token = Digest::SHA1.hexdigest("#{@request_idclient}-#{config.pin}-#{@request_idreference}-#{@request_totalamount}")
    
      @service_client = Savon.client do
        wsdl config.wsdl
        convert_request_keys_to :upcase
      end
      @data_message = {
        request_idclient: @request_idclient,
        request_apikey: @request_apikey,
        request_idreference: @request_idreference,
        request_totalamount: @request_totalamount,
        request_token: @request_token,
        request_date: @request_date
      }

    end

    def query
      begin
        @ws_response = @service_client.call(:transaction_status_execute, message: @data_message)
        response = {status: :success}
        source = ws_response.body[:transaction_status_execute_response][:return]
        data = {
          :return_idclient=>source[:return_idclient], 
          :return_idreference=>source[:return_idreference], 
          :return_token=>source[:return_token], 
          :return_totalamount=>source[:return_totalamount], 
          :return_date=>source[:return_date], 
          :return_dateprocess=>source[:return_dateprocess], 
          :return_auth=>source[:return_auth], 
          :return_transactioncode=>source[:return_transactioncode], 
          :return_transactionmessage=>source[:return_transactionmessage], 
          :return_tokentransactioncode=>source[:return_tokentransactioncode], 
          :return_lastmodified=>source[:return_lastmodified], 
          :return_ip=>source[:return_ip], 
          :return_test=>source[:return_test], 
          :return_wscode=>source[:return_wscode], 
          :return_wsmessage=>source[:return_wsmessage]
        }
        response[:data] = data
      rescue Exception => e
        response = {status: :fail}
      end
      response
    end
  end

end