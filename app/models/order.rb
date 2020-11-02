class Order < ApplicationRecord
    has_many :selections
    belongs_to :user
    belongs_to :shipping_address, :class_name => "Address"
    belongs_to :billing_address, :class_name => "Address"

    validate :correct_amount
    validate :usd

    #Need to update this after
    def correct_amount
        return amount == total
    end

    def total
        total = 0
        self.selections.each do |card|
            total += card.price
        end
        total
    end

    def usd
        return currency == "usd"
    end

    #Returns all unique cards for order
    def cards
        puts "Before order.cards selections: " + selections.size.to_s
        cards = Card.none
        self.selections.each do |selection|
            cards = cards.or(Card.where(id: selection.card.id))
        end
        puts "In order.cards: " + cards.size.to_s
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
