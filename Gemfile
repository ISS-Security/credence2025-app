# frozen_string_literal: true

source 'https://rubygems.org'

# Web
gem 'puma'
gem 'rack-session'
gem 'roda'
gem 'slim'

# Configuration
gem 'figaro'

# Encoding
gem 'base64'

# Debugging
gem 'pry'

# Communication
gem 'http'

# Security
gem 'rbnacl' # assumes libsodium package already installed

# Development
group :development do
  gem 'rake'
  gem 'rubocop'
  gem 'rubocop-performance'
end

group :development, :test do
  gem 'rack-test'
  gem 'rerun'
end
