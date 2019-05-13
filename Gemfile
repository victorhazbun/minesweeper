source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'bcrypt', '~> 3.1', '>= 3.1.12'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'draper', '~> 3.1'
gem 'fast_jsonapi', '~> 1.5'
gem 'jwt', '~> 2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
gem 'rswag-api', '~> 2.0', '>= 2.0.5'
gem 'rswag-ui', '~> 2.0', '>= 2.0.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'massa', '~> 0.5.0'
  gem 'pry-byebug', '~> 3.7'
  gem 'rspec-rails', '~> 3.8'
  gem 'rswag-specs', '~> 2.0', '>= 2.0.5'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara-selenium', '~> 0.0.6'
  gem 'chromedriver-helper', '~> 2.1', '>= 2.1.1'
  gem 'database_cleaner', '~> 1.7'
  gem 'factory_bot_rails', '~> 5.0', '>= 5.0.1'
  gem 'rspec-json_expectations', '~> 2.1'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov', '~> 0.16.1', require: false
  gem 'timecop', '~> 0.9.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
