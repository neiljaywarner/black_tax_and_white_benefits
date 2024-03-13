Feature: Home
    Background:
        Given the app is running

    Scenario: Home screen appears
        Then I see {'Home'} text
        And I see {'Black Tax White Benefits'} text
    
    Scenario: Posts load
        Then I see {'Article 1'} text
        And I see {'Article 2'} text