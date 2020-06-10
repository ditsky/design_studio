module CardsHelper

    #Returns all the filtering options for given card column
    def all_column_filters(column)
        if (column == "CONTENT")
            return Card.distinct.pluck(:content)
        elsif (column == "STYLE")
            return ["painted", "hand cut"]
        elsif (column == "CARD TYPE")
            return Card.distinct.pluck(:card_type)
        end
    end



end
