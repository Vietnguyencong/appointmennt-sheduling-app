# Load the Rails application.
require_relative 'application'
app_env_vars = File.join(Rails.root, 'config', 'initializers', 'app_env_vars.rb')
load(app_env_vars) if File.exists?(app_env_vars)
# Initialize the Rails application.
Rails.application.initialize!

# ActionMailer::Base.smtp_settings = {
#     :user_name => 'apikey',
#     :password => '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',
#     :domain => 'yourdomain.com',
#     :address => 'smtp.sendgrid.net',
#     :port => 587,
#     :authentication => :plain,
#     :enable_starttls_auto => true
#   }
