module CardsHelper

    #Converts filter parameters into an OpenStruct object
    def convert_filters_into_object(filter_param)
        filters = params.fetch(filter_param, {})
        JSON.parse(filters.to_json, object_class: OpenStruct)
    end

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
