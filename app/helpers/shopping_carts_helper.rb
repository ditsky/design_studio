module ShoppingCartsHelper

    def get_selection(cart, card)
        selections = Selection.where(shopping_cart_id: cart.id, card_id: card.id)
        return selections.first
    end

end