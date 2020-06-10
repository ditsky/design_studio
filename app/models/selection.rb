class Selection < ApplicationRecord
    belongs_to :shopping_cart
    belongs_to :card
    belongs_to :order

    validates :shopping_cart_id, presence: true
    validate :valid_cart

    validates :card_id, presence: true
    validate :valid_card

    #Checks if the shopping cart exists
    def valid_cart
        if ShoppingCart.exists?(shopping_cart_id)
            return true
        end
        return false
    end

    #Checks if the card exists
    def valid_card
        if Card.exists?(card_id)
            return true 
        end
       return false
    end
end
