@javascript
Feature: User can RSVP for event through event details page

  As a vistor of the website
  So that I can join the event with minimal overhead
  I want to be able to RSVP for the event

Background:
  Given the following events exist:
    | name             | organization       | description                               | venue_name                 | address_1      | city     | zip   | start                | end                  | how_to_find_us     |
    | Nature Walk      | Nature in the City | A walk through the city                   | The Old Town Hall          | 145 Jackson st | Glendale | 90210 | March 19 2015, 16:30 | March 19 2015, 20:30 | First door on left |
    | Green Bean Mixer | Green Carrots      | If you like beans you'll like this event! | San Francisco City Library | 45 Seneca st   | Phoenix  | 91210 | April 20 2015, 8:30  | April 21 2015, 8:30  | Second door on left|

  And the following guests exist:
  | first_name | last_name | phone          | email            | address            | is_anon |
  | John       | Smith     | (816) 567-8521 | jsmith@site.com  | 12 Washington Blvd | false   |
  | Jacob      | Harrison  | (932) 123-4567 | jharry@gmail.com | 10 Whatever St     | true    |
  | Adam       | Johnson   | (123) 987-4321 | ajohns@yahoo.com | 38 Smithsonian Ave | true    |
  | Mary       | Jackson   | (789) 425-8967 | mjacks@msn.com   | 98 White Horse Ave | true    |
  | Max        | Leroy     | (723) 123-8900 | maxler@aol.com   | 69 Feeling St      | false   |

  And the following registrations exist:
  | event_id | guest_id  |
  | 1        | 1        |
  | 1        | 2        |
  | 1        | 3        |
  | 2        | 1        |
  | 2        | 2        |
  | 2        | 4        |
  | 2        | 5        |

  And I am on the calendar page

Scenario: RSVP form, completed and submitted non-anonymously
  When I click on "Nature Walk" in the calendar
  And I complete the RSVP form non-anonymously
  Then I should see a confirmation message
  And I should see my first name in the panel
  And I should receive a confirmation email

Scenario: RSVP form, completed and submitted anonymously
  When I click on "Nature Walk" in the calendar
  And I complete the RSVP form anonymously
  Then I should see a confirmation message
  And I should not see my first name in the panel
  And I should receive a confirmation email

Scenario: Attempt submission of incomplete RSVP form
  When I click on "Nature Walk" in the calendar
  And I do not complete entire RSVP form
  Then I should see a failure message
  And I should not see my first name in the panel
  And I should not receive a confirmation email

Scenario: Fail submission if email already exists
  When I click on "Nature Walk" in the calendar
  And I complete the RSVP form with email "jsmith@site.com"
  Then I should see a message saying that "jsmith@site.com" already registered
  And "jsmith@site.com" should not receive a confirmation email
