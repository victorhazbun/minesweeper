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
- Initially thought about using jQuery but since it's no longer a Rails dependency, will make sense to use VanillaJS.
- LocalStorage is not the safest way to persist an auth token, signed cookies is a great alternative. But signed cookies only work on the browser.
- The game board will be shown even if the user is not logged in, however it won't show the details of the game unless it's logged in. Similar to what FB does to motivate users to log in.

## Important notes

- I could have used Redis to improve the DB read/write speed.
- Login credentials `demo@example.com:sekret`

## Deployment

[Heroku](https://victor-h-minesweeper.herokuapp.com/)

## Api Docs

[Here](https://victor-h-minesweeper.herokuapp.com/api-docs/index.html)
