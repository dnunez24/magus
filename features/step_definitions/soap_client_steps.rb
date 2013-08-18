Given /^a client object exists$/ do
  options = {
    wsdl: "http://#{hostname}/api/v2_soap?wsdl=1",
    log: false,
    ssl_verify_mode: :none
  }
  @client = Magus::SOAPv2::Client.new(options)
end

When /^I send a login request with (in)?valid credentials$/ do |invalid|
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

Given /^the client is logged in$/ do
  steps %{
    Given a client object exists
    When I send a login request with valid credentials
  }
end

When /^I try to logout$/ do
  VCR.use_cassette "v2_soap_client/logout" do
    @client.logout
  end
end

Then /^the client (?:has|(?:should|does) (not )?have) a (.+?)$/ do |negated, attribute|
  attribute = attribute.downcase.gsub(" ", "_")
  if negated
    expect(@client.send(attribute.to_sym)).to be_nil
  else
    expect(@client.send(attribute.to_sym)).not_to be_nil
  end
end

Then(/^the client (?:(does not )?sends?) a request to end the session$/) do |negated|
  message = {sessionId: @client.session_id}
  if negated
    expect(@client).not_to receive(:call).with(:end_session, message: message)
  else
    expect(@client).to receive(:call).with(:end_session, message: message)
  end
end

Then /^I should receive an error message$/ do
  VCR.use_cassette "v2_soap_client/invalid_login" do
    expect { @client.login(username="baduser", api_key="badpass") }.to raise_exception Magus::SOAPFault
  end
end
