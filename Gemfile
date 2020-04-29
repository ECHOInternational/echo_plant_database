source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 6.0.0'

# Use postgresql as the database for Active Record
gem 'pg'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Use Papertrail for change tracking
gem 'paper_trail', '~>10.3'

# Use Globalize for model translations
gem 'globalize', '~> 5.3'
gem 'globalize-versioning'

# Use Rack-Contrib to add additional middleware
# Currently using Rack::Locale
gem 'rack-contrib'

# Use JWT for authentication
gem 'jwt'

# Use JSON-API as the data format
gem 'jsonapi-resources', '~> 0.9.0'
gem 'jsonapi-swagger'

# User Pundit
gem 'pundit'
gem 'jsonapi-authorization'

# Use Graphql
gem 'graphql', '~>1.10'
gem 'search_object_graphql'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Allow access to AWS for uploads
gem 'aws-sdk-s3', '~> 1'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
    gem 'pry'
  	gem 'pry-byebug'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
