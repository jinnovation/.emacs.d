Feature: Projectile
  Background:
    Given the buffer is empty
    When I insert "test input"

  Scenario: Automatically run tests on write
    When I press "SPC w"
    Then it should save the buffer
    # And it should run the default Projectile test command
    
  Scenario: Automatically run tests on write; force command prompt
    When I press "C-u SPC w"
    Then it should save the buffer
    # And it should prompt for the test command to run
