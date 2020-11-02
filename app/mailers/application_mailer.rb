class ApplicationMailer < ActionMailer::Base
  helper CardsHelper
  default from: 'jennifer@jennifersdesignstudio.org'
  layout 'mailer'
end
