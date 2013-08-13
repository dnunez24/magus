Feature: Magento SOAP (Version 2) Client logout

  Magento SOAP (Version 2) client logs out of an existing
  session and deletes the stored session ID

  Background:
    Given a client object exists

  Scenario: Client has existing session ID
    Given the client is logged in
    And the client has a session ID
    When I send a logout request
    Then the service ends the session
    And the client should not have a session ID

  Scenario: Client does not have a session ID
    Given the client does not have a session ID
    When I send a logout request
    Then the client responds with: "Client has no session ID"