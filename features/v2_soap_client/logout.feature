Feature: Magento SOAP (Version 2) Client logout

  Magento SOAP (Version 2) client logs out of an existing
  session and deletes the stored session ID

  Background:
    Given a client object exists
    And the client is logged in
    And the client has a session ID

  Scenario: Successfully logout of session
    When I send a logout request
    Then the service ends the session
    And the client should not have a session ID
