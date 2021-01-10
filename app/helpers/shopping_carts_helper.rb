module ShoppingCartsHelper

    def get_selection(cart, card)
        if logged_in?
            selections = Selection.where(shopping_cart_id: cart.id, card_id: card.id)
            return selections.first
        end

        return selection_path(:id => card.id)
    end

    def selections_size(cart)
        if logged_in?
            return cart.selections.size
        end

        return cart.size
    end

end