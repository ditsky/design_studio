module CardsHelper

    #Returns all the filtering options for given card column
    #Can make this better
    def all_column_filters(column)
        if (column == "DESIGN" || column == "Design")
            return Card.distinct.pluck(:content)
        elsif (column == "STYLE" || column == "Style")
            return ["painted", "hand cut"]
        elsif (column == "CARD TYPE" || column == "Card Type")
            return Card.distinct.pluck(:card_type)
        elsif (column == "SIZE" || column == "Size")
            return Card.distinct.pluck(:size)
        end
    end

    #Converts int prices into proper dollar string amount
    def price_to_string(price)
        if (!price)
            return "0"
        end
        price = price.round(2)
        price_string = price.to_s
        first_cent_index = price_string.index(".") + 1
        cent_len = price_string.length - first_cent_index
        if cent_len < 2
            price_string += "0"
        elsif cent_len > 2
            price_string = price_string[0,first_cent_index + 2]

        end

        return price_string
    end

end
