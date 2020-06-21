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
    @order = order
    @cards = Card.none
    @order.selections.each do |selection|
      @cards = @cards.or(Card.where(id: selection.card.id))
    end
    @sizes = {}
    @cards.each do |card|
      @sizes[card.id] = @order.selections.where(card_id: card.id).count
    end
    mail to: user.email, subject: "Order Receipt"
  end
end
