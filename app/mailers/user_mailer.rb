class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end

  def order_receipt(user, order)
    @user = user
    @cards = order.cards
    @sizes = order.card_totals
    mail to: user.email, subject: "Order Receipt"
  end


  def order_created(order)
    puts "In mailer: " + order.cards.size.to_s
    @order = order
    @cards = @order.cards
    @sizes = @order.card_totals
    mail to: ENV['ADMIN_EMAIL'], subject: "You Have Recieved an Order!"
  end
end
