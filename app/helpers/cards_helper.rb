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
        elsif (column == "SHAPE/SIZE" || column == "Shape/Size")
            return Card.distinct.pluck(:size)
        end
    end

    def design_to_string(design)
        return design.split('_').map(&:capitalize).join(' ')
    end

    def remove_filter(request, filter)
        url = URI request.original_url()
        params = Rack::Utils.parse_query(url.query)
        if params["filters[]"].class == String
            params["filters[]"] = [params["filters[]"]]
        end
        params[:filters] = params["filters[]"]
        params.delete("filters[]")
        params[:filters].delete(filter)

        url.query = params.to_param
        return url.to_s
    end

    #Converts int prices into proper dollar string amount
    def price_to_string(price)
        if (!price)
            return "0"
        end
        price_string = price.to_s
        if !price_string.include? "."
            return price_string
        end

        price = price.round(2)

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
