Feature: View Analytics
Scenario: User navigates to view all players
    Given I am logged in as a coach
    And player "John Smith" exists
    When I click "See Players"
    Then I am on the Players Index page
    And I should see "John Smith"
Scenario: User navigates to view all players but there are no players
    Given the database has been reset
    Given I am logged in as a coach
    When I click "See Players"
    Then I am on the Players Index page
    And I should see "No data"
Scenario: User navigates to view routes 
    Given I am logged in as a coach
    And player "John Smith" exists
    And "John Smith" has run a route
    When I click "See All"
    Then I am on the Route Instances Index page
    And I should see "John Smith"
    And I should see "curl"
Scenario: User navigates to view routes by player
    Given I am logged in as a coach
    And player "John Smith" exists
    And "John Smith" has run a route
    When I click "See Routes by player"
    Then I am on the By Player page
    And I should see "No columns selected"
Scenario: User navigates to view routes by player and selects a route
    Given I am logged in as a coach
    And player "John Smith" exists
    And "John Smith" has run a route
    When I click "See Routes by player"
    And I click "curl"
    Then I should see "John Smith"
    And I should see "curl"
    And I should see "100.00%"
Scenario: User navigates to view routes by player and removes all routes
    Given I am logged in as a coach
    And player "John Smith" exists
    And "John Smith" has run a route
    When I click "See Routes by player"
    And I click "curl"
    And I click the remove link
    Then I should see "No columns selected"
Scenario: User submits the date fields
    Given I am logged in as a coach
    And player "John Smith" exists
    And "John Smith" has run a route
    When I click "See Routes by player"
    And I submit the form
    Then I am on the By Player page
    And I should see "No columns selected"
Scenario: User navigates to player report card
    Given I am logged in as a coach
    And player "John Smith" exists
    And "John Smith" has run a route
    When I click "See Routes by player"
    And I click "curl"
    And I click "John Smith"
    Then I am on the Player Show page for "John Smith"
    And I should see "John Smith"
    And I should see "curl"
    And I should see "100.00%"
Scenario: User navigates to player report card and adds a route to the chart
    Given I am logged in as a coach
    And player "John Smith" exists
    And "John Smith" has run a route
    When I click "See Routes by player"
    And I click "curl"
    And I click "John Smith"
    And I click "+"
    Then I should see "-"
Scenario: User navigates to player report card and changes date
    Given I am logged in as a coach
    And player "John Smith" exists
    And "John Smith" has run a route
    When I click "See Routes by player"
    Then I am on the By Player page
    When I click "curl"
    And I click "John Smith"
    And I submit the form
    Then I am on the Player Show page for "John Smith"

