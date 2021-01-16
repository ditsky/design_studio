require 'truemail'

Truemail.configure do |config|
  # Required parameter. Must be an existing email on behalf of which verification will be performed
  config.verifier_email = ENV['DEV_EMAIL']
end