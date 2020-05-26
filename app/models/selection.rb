class Selection < ApplicationRecord
    belongs_to :shopping_cart
    belongs_to :card

    validates :shopping_cart_id, presence: true
    validate :valid_cart

    validates :card_id, presence: true
    validate :valid_card

    #Checks if the shopping cart exists
    def valid_cart
        return true unless ShoppingCart.find(shopping_cart_id).nil?
    end

    #Checks if the shopping cart exists
    def valid_card
        return true unless Card.find(card_id).nil?
    end
end
