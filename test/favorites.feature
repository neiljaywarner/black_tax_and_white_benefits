Feature: Favorites
    Background:
        Given the app is running

    Scenario: Favorites tab is visible
        Then I see {'Favorites'} text
        And I see {Icons.star} icon

    Scenario: Navigate to favorites tab
        When I tap {Icons.star} icon
        Then I don't see {"Article 1"} text