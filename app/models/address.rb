class Address < ApplicationRecord
    belongs_to :user

    def toString()
        return address_line_1
    end
end
