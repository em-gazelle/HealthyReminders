# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
OpTakeMyMeds::Application.initialize!

# Configuring Devise on Heroku to send out password reset links
config.action_mailer.default_url_options = { :host => 'pure-reaches-7966.heroku.com' }
