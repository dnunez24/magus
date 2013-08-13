Given(/^a client object exists$/) do
  options = {
    wsdl: "http://#{hostname}/api/v2_soap?wsdl=1",
    log: false,
    ssl_verify_mode: :none
  }
  @client = Magus::SOAPv2::Client.new(options)
end

When(/^I send a login request with (in)?valid credentials$/) do |invalid|
  username = invalid ? "baduser" : v2_soap_creds["username"]
  api_key = invalid ? "badpass" : v2_soap_creds["api_key"]
  cassette_name = invalid ? "invalid_login" : "valid_login"

  VCR.use_cassette "v2_soap_client/#{cassette_name}" do
    begin
      @client.login(username, api_key)
    rescue
    end
  end
end

Given(/^the client is logged in$/) do
  steps %{
    Given a client object exists
    When I send a login request with valid credentials
  }
end

Given(/^the client has a session ID$/) do
  expect(@client.session_id).not_to be_nil
end

When(/^I send a logout request$/) do
  @client.logout
end

Then(/^the client should (not )?have a (.+?)$/) do |negated, attribute|
  attribute = attribute.downcase.gsub(" ", "_")
  if negated
    expect(@client.send(attribute.to_sym)).to be_nil
  else
    expect(@client.send(attribute.to_sym)).not_to be_nil
  end
end

Then(/^I should receive an error message$/) do
  VCR.use_cassette "v2_soap_client/invalid_login" do
    expect { @client.login(username="baduser", api_key="badpass") }.to raise_exception Magus::SOAPFault
  end
end

Then(/^the service ends the session$/) do
  pending # express the regexp above with the code you wish you had
end