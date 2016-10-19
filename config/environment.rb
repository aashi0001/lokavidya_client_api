# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
Rails.application.configure do

config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {   
    :openssl_verify_mode => OpenSSL::SSL::VERIFY_NONE,      
    :enable_starttls_auto => true,  #this is the important stuff!
    :address        => 'smtp.gmail.com',
    :port           => 587,
    :domain         => 'localhost',
    :authentication => :plain,
    :user_name      => 'klotheskart@gmail.com',
    :password       => 'kidan@123#'
  } 
end
