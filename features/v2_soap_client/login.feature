Feature: Magento SOAP (Version 2) Client login

  Magento SOAP (Version 2) client generates a login request,
  retrieves and stores a session ID

  Background:
    Given a client object exists

  Scenario: Request login with valid credentials
    When I send a login request with valid credentials
    Then the client should have a session ID

  Scenario: Request login with invalid credentials
    When I send a login request with invalid credentials
    Then the client should not have a session ID
    And I should receive an error message
