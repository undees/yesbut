Feature: Cut, copy, paste
  As a writer
  I want to move text around quickly
  So that I can sketch and refine ideas

  Scenario: Copy and paste
    Given a new document
    When I type "itchy"
    And I copy all the text
    Then the text should be "itchy"
    When I change the text to "scratchy"
    And I paste over the text
    Then the text should be "itchy"
    
  Scenario: Cut and paste
    Given a new document
    When I type "pineapple"
    And I cut all the text
    Then the text should be empty
    When I type "mango"
    And I paste over the text
    Then the text should be "pineapple"
