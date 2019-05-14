# Minesweeper

Classic game Minesweeper

## The Stack

* Ruby 2.6.3
* Rails 5.2.3
* Postgres

## Setup

* clone the repo

```
$ bundle install
$ bundle exec rake db:create db:migrate
--- if db:migrate raises errors ---
$ bundle exec rake db:schema:load
--- end if ---
$ rails s
```

* Navigate to localhost:3000

## Specs

`$ bundle exec rspec`

## Coverage

`$ open coverage/index.html`

## Decisions taken

- JWT for authentication since this API could be used on mobile, desktop apps, etc.
- Swagger for API documentation, it's being generated from the specs. Two birds with one shot.
- Initially thought about using jQuery but since it's no longer a Rails dependency, will make more sense to use VanillaJS.
- LocalStorage is not the safest way to persist an auth token, signed cookies is a great alternative. But signed cookies only work on the browser.
- The game board will be shown even if the user is not logged in, however it won't show the details of the game unless it's logged in. Similar to what FB does to motivate users to log in.
- Fast JSON API for performance, 25 times faster than AMS.
- To determine how much time a match taked I use `#distance_of_time_in_words`, in this particular scenario is fine but if the requirements change and the application needs to load multiple games then the server response will become slow. To improve it, I can move the time distance calculation into the front-end.
- Decorators to wrap certain models like the game model, for presentational concerns.
- Timecop for solid time navigation on tests.
- Chronic for datetime parsing, every client can use a different date format, the backend will handle it. The standard is `ISO8601`.
- Would be nice to add Rubocop. With more time I could do that.

## Important notes

- I could have used Redis to improve the DB read/write speed.
- 100% test coverage.
- I aimed for quality instead of quantity.
- Integration specs for the API.
- System specs for user behaivour on the browser.
- With more time I could implement the cell API endpoints and complete the game board.
- Login credentials `demo@example.com:sekret`.
- For the Swagger API Docs you will need to send the `X-Authorization-Token` token, so first make authenticate a user and then use the token from the response.

## Deployment

[Heroku](https://victor-h-minesweeper.herokuapp.com/)

## Api Docs

[Here](https://victor-h-minesweeper.herokuapp.com/api-docs/index.html)
