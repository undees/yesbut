Feature: Undo / redo
  As a person who makes mistakes
  I want to be able to undo and redo changes
  So that I can improve my documents

  Scenario: Multiple undo
    Given a new document
    When I type "abc"
    And I change the text to "def"
    And I undo my changes
    Then the text should be "abc"
    When I undo my changes again
    Then the text should be empty
