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

    def total
        total = 0
        self.cards.each do |card|
            if (card.price)
                total += card.price
            end
        end
        total.to_i
    end

    def card_count
        self.cards.size
    end
end
