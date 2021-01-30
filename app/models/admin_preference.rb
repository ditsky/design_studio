class AdminPreference < ApplicationRecord
    
    validate :unique_fields

    def unique_fields
        values = [homeDesign1, homeDesign2, homeDesign3, homeDesign4]
        if values.detect{ |preference| values.count(preference) > 1 }.nil?
            return true
        end
        errors.add(:unique_fields, "can't duplicate a field")
    end


end