require 'spec_helper'

module Magus::SOAPv2
  describe Client, :soap do
    subject(:client) { Client.new(options) }
    let(:username) { v2_soap_creds["username"] }
    let(:api_key) { v2_soap_creds["api_key"] }
    let(:options) do
      {
        wsdl: "http://#{hostname}/api/v2_soap?wsdl=1",
        log: false,
        ssl_verify_mode: :none
      }
    end

    describe "#login" do
      context "with valid credentials", vcr: {cassette_name: "soapv2/client/login/valid_credentials"} do
        it "sends a SOAP login message" do
          message = {username: username, apiKey: api_key}
          expect(client).to receive(:call).with(:login, message: message).and_call_original
          client.login(username, api_key)
        end

        it "sets the session ID" do
          client.login(username, api_key)
          expect(client.session_id).to match /[a-f0-9]{32}/
        end

        it "returns the client instance" do
          response = client.login(username, api_key)
          expect(response).to be client
        end
      end

      context "with invalid credentials", vcr: {cassette_name: "soapv2/client/login/invalid_credentials"} do
        it "raises a SOAP fault exception" do
          username = "baduser"
          api_key = "badpass"
          expect { client.login(username, api_key) }.to raise_exception Magus::SOAPFault
        end
      end
    end # login
  end # Client
end # Magus::SOAPv2
