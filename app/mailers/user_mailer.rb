class UserMailer < ApplicationMailer
  include CardsHelper

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    headers['X-Entity-Ref-ID'] = "1"
    mail to: user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    headers['X-Entity-Ref-ID'] = "2"
    mail to: user.email, subject: "Password reset", template_id: "d-2eeb9c9ab0234695908aacdee26708cf"
  end


  def order_receipt(email, name, order)
    @total = order.string_total
    @email = email
    @name = name
    @cards = order.cards
    @sizes = order.card_totals
    headers['X-Entity-Ref-ID'] = "3"
    mail to: email, subject: "Order Receipt"
  end


  def order_created(order)
    @total = price_to_string(order.total)
    @cards = order.cards
    @sizes = order.card_totals
    headers['X-Entity-Ref-ID'] = "4"
    mail to: ENV['ADMIN_EMAIL'], subject: "You Have Recieved an Order!"
  end

  def order_shipped(user_id, email, name, order)
    @has_account = user_id != -1
    @email = email
    @name = name
    @order = order
    @cards = order.cards
    @address = order.shipping_address
    @valid = true
    if (@address == "ERROR NO SHIPPING ADDRESS")
      @valid = false
    end
    headers['X-Entity-Ref-ID'] = "5"
    mail to: email, subject: "Order Shipped!"
  end

  def newsletter(users = User.all, email = "testing preview")
    @users = users
    @body = email
    headers['X-Entity-Ref-ID'] = "6"
    mail to: users.map(&:email).uniq, subject: "Jennifer's Design Newsletter", template_id: "d-2eeb9c9ab0234695908aacdee26708cf"
  end

end
