module CardsHelper

    #Converts filter parameters into an OpenStruct object
    def convert_filters_into_object(filter_param)
        filters = params.fetch(filter_param, {})
        JSON.parse(filters.to_json, object_class: OpenStruct)
    end

end
