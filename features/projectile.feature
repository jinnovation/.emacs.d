Feature: Projectile

  Scenario: Automatically run tests on write
    When I press "<leader> w"
    Then it should save the buffer
    And it should run the default Projectile test command
    
  Scenario: Automatically run tests on write; force command prompt
    When I press "prefix <leader> w"
    Then it should save the buffer
    And it should prompt for the test command to run
