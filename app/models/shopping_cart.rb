class ShoppingCart < ApplicationRecord
    belongs_to :user, required: false
    has_many :selections
    has_many :cards, through: :selections
end
