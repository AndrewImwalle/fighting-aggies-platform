# frozen_string_literal: true

# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'cucumber/rails'
require 'simplecov'
require 'fileutils'
require 'capybara/rails'

# frozen_string_literal: true

# Capybara defaults to CSS3 selectors rather than XPath.
# If you'd prefer to use XPath, just uncomment this line and adjust any
# selectors in your step definitions to use the XPath syntax.
# Capybara.default_selector = :xpath

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     # { except: [:widgets] } may not do what you expect here
#     # as Cucumber::Rails::Database.javascript_strategy overrides
#     # this setting.
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   Before('not @no-txn', 'not @selenium', 'not @culerity', 'not @celerity', 'not @javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end
#

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation

Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('headless')
  options.add_argument('no-sandbox')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
end

exclude_folders = ['app/controllers/api/v1/', 'app/models/analysis.rb', 'app/models/video.rb',
                   'app/models/vision.rb']
SimpleCov.start 'rails' do
  for folder in exclude_folders do
    add_filter folder
  end
  #
  #   current_dir = FileUtils.pwd
  #   dummy_video_path = File.join(current_dir, 'storage', 'dummy_video.mp4')
  #
  #   Before do |_scenario|
  #     @login_url = 'http://localhost:8080'
  #     @dummy_file_loc = dummy_video_path
  #     @good_file_loc = File.join(current_dir, 'storage', 'supplementary_video.mp4')
  #     FileUtils.touch(dummy_video_path)
  #     Capybara.default_host = 'http://localhost:3000' # This is very important!
  #
  #     OmniAuth.config.test_mode = true
  #     OmniAuth.config.add_mock(:default, {
  #                                info: {
  #                                  email: 'faaplicationuser@gmail.com',
  #                                  name: 'test user',
  #                                  password: 'password2023'
  #                                }
  #                              })
  #   end
  #
  #   After do |_scenario|
  #     FileUtils.rm(dummy_video_path)
  #   end
end
