class Address < ApplicationRecord
    belongs_to :user, optional: true
    validates :full_name, presence: true, allow_blank: false
    validates :address_line_1, presence: true, allow_blank: false
    validates :city, presence: true, allow_blank: false
    validates :zip, presence: true, allow_blank: false
    validates :country, presence: true, allow_blank: false

    def toString()
        return address_line_1
    end
end
