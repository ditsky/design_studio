class Order < ApplicationRecord
    has_many :selections
    belongs_to :user
    belongs_to :shipping_address, :class_name => "Address"
    belongs_to :billing_address, :class_name => "Address"

    validate :correct_amount
    validate :usd

    #Need to update this alter
    def correct_amount
        return amount == self.selections.size * 5 
    end

    def usd
        return currency == "usd"
    end

    #Returns all unique cards for order
    def cards
        cards = Card.none
        self.selections.each do |selection|
            cards = cards.or(Card.where(id: selection.card.id))
        end
        return cards
    end

    #Returns number of occurences of given card in order
    def card_count(card_id)
        return self.selections.where(card_id: card_id).count
    end

    #Returns a hash with number of occurences for each card in the order
    def card_totals
        sizes = {}
        self.cards.each do |card|
            sizes[card.id] = card_count(card.id)
        end
        return sizes
    end
    

end
