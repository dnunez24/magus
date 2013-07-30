Given(/^a client object doesn't exist$/) do
  @client = nil
end

When(/^I initialize the client with valid credentials$/) do
  credentials = load_credentials("soapv2")
  username = credentials["username"]
  api_key = credentials["api_key"]
  @client = Magento::SOAPv2::Client.new(username, api_key)
end

Then(/^the client should have a (.*?)$/) do |attribute|
  expect(@client).to respond_to attribute.to_sym
end
