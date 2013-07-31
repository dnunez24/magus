require 'spec_helper'

module Magento
  module SOAPv2
    describe Client, ".new" do
      it "generates a login request" do
        pending "last_request should match XML for login SOAP method"
        username = "jdoe"
        api_key = "password"
        Client.new(username, api_key)
        expect(last_request).to match_valid_xml_body_for :login
      end

      it "sets @session_id to the session ID from the login request" do
        pending "validate client#session_id against last_request session ID"
      end
    end
  end
end