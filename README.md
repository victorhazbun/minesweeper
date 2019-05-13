# Minesweeper

Classic game Minesweeper

## The Stack

* Ruby 2.6.3
* Rails 5.2.3
* Postgres
* jQuery

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

## Decisions taken

- JWT for authentication since this API could be used on mobile, desktop apps, etc.
- Swagger for API documentation, it's being generated from the specs. Two birds with one shot.

## Important notes

- I could have used Redis to improve the DB read/write speed.
- Login credentials `demo@example.com:sekret`

## Deployment

[Heroku](https://victor-h-minesweeper.herokuapp.com/)

## Api Docs

[Here](https://victor-h-minesweeper.herokuapp.com/api-docs/index.html)
