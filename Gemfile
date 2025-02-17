source "https://rubygems.org"

gem "rails", "~> 8.0.1"

gem "pg", "~> 1.1"

gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails", "~> 1.4"
gem "jsbundling-rails", "~> 1.3"

gem "jbuilder"
gem "slim-rails", "~> 3.7.0"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "pagy", "~> 9.3"

group :development, :test do
  gem "pry", "~> 0.15.0"
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "faker"
  gem "rubocop", "~> 1.72", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "factory_bot_rails"
  gem "rspec-rails", "~> 6.1.0"
  gem "rubocop-rspec", require: false
  gem "shoulda-matchers"
  gem "rails-controller-testing"
  gem "database_cleaner-active_record"
end
