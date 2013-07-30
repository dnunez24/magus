Feature: Configuration


  Scenario Outline: Configure directly
    Given a file named "configuration.rb" with:
    """
    require 'magus'

    <attribute> = "<value>"
    print <attribute>
    """
    When I run `ruby configuration.rb`
    Then the output should contain exactly "<value>"
    And the exit status should be 0

    Examples:
      | attribute        | value                           |
      | Magento.endpoint | http://www.example.com/api/soap |
      | Magento.username | jdoe                            |
      | Magento.api_key  | password                        |


  Scenario Outline: Configure with block syntax
    Given a file named "configuration.rb" with:
      """
      require 'magus'

      Magento.configure do |c|
        <option> = "<value>"
      end

      print <attribute>
      """
    When I run `ruby configuration.rb`
    Then the output should contain exactly "<value>"
    And the exit status should be 0

    Examples:
      | option     | attribute        | value                           |
      | c.endpoint | Magento.endpoint | http://www.example.com/api/soap |
      | c.username | Magento.username | jdoe                            |
      | c.api_key  | Magento.api_key  | password                        |
