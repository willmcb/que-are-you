# Que-are-you

App to allow you to easily share e-business cards at events using QR codes.
Completed in 8 days using agile methods as a part of Makers course.

- [Heroku app](http://que-are-you.herokuapp.com)

## Technologies
- Ruby / Rails (backend language / framework)
- jQuery / JavaScript (frontend code)
  - jsQR (library for reading QR codes)
  - rQRcode (ruby QR encoding library)
- PostgreSQL, DatabaseCleaner (database)
- Google Calendar API (for events data)
- Google Maps API (for location presentation)
- Heroku (deployment)
- Bootstrap (frontend styles)
- Rspec, Capybara, FactoryBot (testing)

## Quickstart

First, clone this repository. Then:

```bash
> bundle install
> rails db:create
> rails db:migrate

> bundle exec rspec # Run the tests to ensure it works
> rails server # Start the server at localhost:3000
```

## For google calendar connection feature

You'll need a google OAuth client ID and client secret ID
and place these in environment variables: 'GOOGLE_CLIENT_ID' and 'GOOGLE_CLIENT_SECRET'
(example instructions found here https://medium.com/@amoschoo/google-oauth-for-ruby-on-rails-129ce7196f35)

## Minimum Viable Product
- User signup / signin
- Adding business cards by scanning QR code
- User can see a list of business cards
- User can see their profile/card
- User can edit their profile/card

## Specification
- User has to sign in to use the app
- User profile
  - user can see their own profile page that includes
    - information
    - profile picture
  - user can edit their own profile
- Events
  - user can connect to Google Calendar
  - user can choose an event from the list of their Google Calendar events
  - user can set 'other' event
  - chosen event appears on the Home page
- Location
  - user can allow browser to access their Location
  - location is saved when adding a card
- Business cards
  - user can scan scan a QR code to add a card
  - added cards appear in Business cards page
  - user can search cards by name
  - user can view associates' profile that includes:
    - associate's information
    - associate's profile image
    - event they met at
    - map showing location they met at
  - user can send a message
  - user can remove a card
- Messages
  - user can see messages they sent
  - user can see messages they received


  ## How to contribute to this project
  See [CONTRIBUTING.md](CONTRIBUTING.md)
