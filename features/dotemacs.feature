Feature: Helm

  Scenario: M-x
    When I press "SPC m"
    Then I should have a buffer named "*helm M-x*"
