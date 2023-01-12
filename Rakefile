# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :setup do
  task :npm_yarn do
    system('sudo apt upgrade')
    system('sudo apt update')
    system('npm install')
    system('npm install --global yarn')
    system('yarn install')
  end
end
