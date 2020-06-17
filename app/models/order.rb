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

end
