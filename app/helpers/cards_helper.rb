module CardsHelper

    #Returns all the filtering options for given card column
    def all_column_filters(column)
        if (column == "CONTENT" || column == "Content")
            return Card.distinct.pluck(:content)
        elsif (column == "STYLE" || column == "Style")
            return ["painted", "hand cut"]
        elsif (column == "CARD TYPE" || column == "Card Type")
            return Card.distinct.pluck(:card_type)
        end
    end



end
