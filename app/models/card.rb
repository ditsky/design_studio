class Card < ApplicationRecord
    has_many :selections
    has_many :shopping_carts, through: :selections
end
