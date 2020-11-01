source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'bcrypt', '~> 3.1.7'

group :development, :test do
	gem 'pry-byebug'
  gem "factory_bot_rails"
  gem "rspec-rails", "~> 4.0"
  gem "rails-controller-testing", "~> 1.0"
  gem "shoulda-matchers", "~> 4.4"
  gem 'dotenv-rails'
end

group :development do
	gem 'web-console', '>= 3.3.0'
	gem 'listen', '~> 3.2'
end

group :test do
	gem 'capybara', '>= 2.15'
	gem 'selenium-webdriver'
	gem 'webdrivers', '~> 4.0', require: false
end

gem 'carrierwave-aws'
