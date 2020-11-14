class Order < ApplicationRecord
    include CardsHelper
    has_many :selections
    belongs_to :user
    belongs_to :shipping_address, :class_name => "Address"
    belongs_to :billing_address, :class_name => "Address"

    validate :correct_amount
    validate :usd
    validates :user_id, :presence => true
    validates :payment_intent, uniqueness: true

    def shipping_address
        if (Address.exists?(shipping_address_id))
            return Address.find(shipping_address_id)
        else 
            return "ERROR NO SHIPPING ADDRESS"
        end
    end

    def send_shipping_email
        user.send_shipping_email(self)
    end

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

    def string_total
        price_to_string(total)
    end

    #Converts int prices into proper dollar string amount
    # def price_to_string(price)
    #     if (!price)
    #         return "0"
    #     end
    #     price = price.round(2)
    #     price_string = price.to_s
    #     first_cent_index = price_string.index(".") + 1
    #     cent_len = price_string.length - first_cent_index
    #     if cent_len < 2
    #         price_string += "0"
    #     elsif cent_len > 2
    #         price_string = price_string[0,first_cent_index + 2]

    #     end

    #     return price_string
    # end

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
