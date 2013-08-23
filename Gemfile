source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', '4.0.0'
## these two are required for rails 4 compatibility and heroku
gem 'protected_attributes'
gem 'rails_12factor', group: :production
gem 'heroku'

gem 'pg'
gem 'koala'
gem 'will_paginate'
gem 'nokogiri'
gem 'simple_form'
gem 'rturk'
require 'uri'
require 'csv'
gem 'activerecord-session_store', github: 'peterkinnaird/activerecord-session_store'
#gem 'omniauth'
gem 'zurb-foundation'
gem 'omniauth-persona'
gem 'omniauth-twitter'
gem 'will_paginate'
gem 'bitly'
gem 'jquery-validation-rails'
gem 'twitter'
gem 'ruby-aws', github: 'jwnichls/ruby-aws'
gem "highline", "~> 1.6.19"

# Put Twitter config variables into a separate file
gem 'dotenv-rails', :groups => [:development, :production]

group :development do
	gem 'annotate'
	gem 'debugger'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails' 
  gem 'less'
  gem 'therubyracer', :platforms => :ruby
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'bourbon'
end

gem 'jquery-rails'
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

group :test do
  gem 'factory_girl_rails'
  gem 'autotest-rails'
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'timecop'
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
