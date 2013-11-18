require 'spec_helper'

describe "ries_interpagos" do 
  before(:each) do
    RiesInterpagos.configure do |config|
      # config.wsdl = "https://secure.interpagos.net/apps/webservices/WS_TransactionStatus/index.php?wsdl"
      config.wsdl = "http://estebans-macbook-pro.local:8080/?WSDL"
      config.api_key = "WSTXST102939KJD9E9393939"
      config.id_cliente = "1773"
      config.pin = "Q2BUQJ27HNE7TFRN"
    end
  end
  it "handles configuration" do
    RiesInterpagos.configuration.wsdl.should eq("http://estebans-macbook-pro.local:8080/?WSDL")
    RiesInterpagos.configuration.api_key.should eq("WSTXST102939KJD9E9393939")
    RiesInterpagos.configuration.id_cliente.should eq("1773")
  end
  describe "It handles messaging" do
    before(:each) do
      @msg = RiesInterpagos.create_message do |message|
        message.reference = "123"
        message.total_amount = "123"
        message.request_date = "123"
      end
    end
    it "creates a message" do
      @msg.api_key.should eq(RiesInterpagos.configuration.api_key)
      @msg.id_cliente.should eq(RiesInterpagos.configuration.id_cliente)
      @msg.reference.should eq("123")
    end
    describe "make the request" do
      before(:each) do
        @client = RiesInterpagos.create_client(@msg)
      end
      it "builds a client" do 
        @client.request_apikey.should eq(RiesInterpagos.configuration.api_key)
        @client.request_totalamount.should eq("123.00")
      end
      it "should call the service" do
        response = @client.query
        p response
      end
    end
  end
end