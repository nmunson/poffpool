# Load the rails application
require File.expand_path('../application', __FILE__)

# Load environment vars from local file
heroku_env = File.join(Rails.root, 'config', 'environment_vars.rb')
load(heroku_env) if File.exists?(heroku_env)

# Initialize the rails application
Poffpool::Application.initialize!
