class ShoppingCart < ApplicationRecord
    belongs_to :user, required: false
    has_many :selections
    has_many :cards, through: :selections

    def order_selections(order)
        self.selections.update_all(order_id: order.id)
    end

    def clear
        self.selections.delete_all
    end
end
