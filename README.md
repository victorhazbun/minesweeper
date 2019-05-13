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

* Navigate to http://localhost:3000

## Deployment

[Heroku](https://victor-h-minesweeper.herokuapp.com/)
