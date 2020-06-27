class Card < ApplicationRecord
    #associations
    has_many :selections
    has_many :shopping_carts, through: :selections
    has_many :images
    has_many_attached :images_s3
    has_one_attached :display_s3

    validates :short_description, uniqueness: true

    #filters for index page
    scope :filter_by_content, -> (content) {where content: content}
    scope :filter_by_card_type, -> (card_type) {where card_type: card_type}
    scope :filter_by_painted, -> (painted) {where painted: painted}
    scope :filter_by_hand_cut, -> (hand_cut) {where hand_cut: hand_cut}

    #Method for adding card to an order
    def order_card(card, order)
        card.update(order_id: order.id)
    end

end
