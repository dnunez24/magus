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

    describe "#logout" do
      context "when client has a session ID", vcr: {cassette_name: "soapv2/client/logout/with_session_id"} do
        it "sends a SOAP request to end the session" do
          client.login(username, api_key)
          message = {sessionId: client.session_id}
          expect(client).to receive(:call).with(:end_session, message: message).and_call_original
          client.logout
        end

        it "destroys the stored session ID" do
          client.login(username, api_key)
          client.logout
          expect(client.session_id).to be_nil
        end

        it "returns the client instance" do
          client.login(username, api_key)
          response = client.logout
          expect(response).to be client
        end
      end

      context "when client has no session ID", vcr: {cassette_name: "soapv2/client/logout/with_no_session_id"} do
        it "does not send a SOAP request to end the session" do
          message = {sessionId: client.session_id}
          expect(client).not_to receive(:call).with(:end_session, message: message)
          client.logout
        end

        it "returns the client instance" do
          expect(client.logout).to be client
        end
      end
    end # logout
  end # Client
end # Magus::SOAPv2
