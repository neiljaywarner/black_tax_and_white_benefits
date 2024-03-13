Feature: Post
    Background:
        Given the app is running

    Scenario: Article loads
        When I tap {'Article 1'} text
        Then I see {Icons.share} icon
        And I see {Icons.star_border} icon
        And I see {'Something big happened'} text