Feature: Magento SOAP (Version 2) Client

  Create a Magento SOAP (Version 2) client for handling web service requests


  Background:
    Given a client object doesn't exist

  Scenario: Initialize the client with valid credentials
    When I initialize the client with valid credentials
    Then the client should have a session_id

  Scenario: Initialize the client with invalid credentials
    When I initialize the client with invalid credentials
    Then the client should not have a session_id
    And I should receive an error message
