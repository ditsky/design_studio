class ShoppingCart < ApplicationRecord
    belongs_to :user
    has_many :selections
    has_many :cards, through: :selections
end
