Story: Action!

As an easily entertained person
I want things to happen when I push buttons
So that I can squeal with glee

  Scenario: Changing text
    Given a list of items
    When I scroll to row 10
    And I touch the row marked "Go to page 1"
    And I touch the "Click me" button
    Then the label text should be "Button clicked on: Page 1"
