# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def newsletter()
    users = User.all
    body = params[:email_body] || "No message for testing"
    UserMailer.newsletter(users, body)
  end


end
