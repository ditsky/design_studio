module FilterManager

    class CardFilter

        def filter(params, columns)
            filtered_result = get_filtered_result(params, columns[0])
            columns.delete_at(0)
            columns.each do |column|
                filtered_result = filtered_result.merge(get_filtered_result(params, column))
            end
            return filtered_result
        end

        def get_filtered_result(params, column)
            if (column == :painted || column == :hand_cut)
                filter_symbols = [column]
            else
                filter_symbols = Card.distinct.pluck(column)
                filter_symbols.each do |symbol|
                    symbol = symbol.parameterize.underscore.to_sym
                end 
            end
            return filter_by_scope(params, filter_symbols, column)
        end

        def filter_by_scope(params, filter_symbols, column)
            all_cards = Card.all
            filtered_result = Card.none
            filter_symbols.each do |symbol|
                if params[symbol] == "1"
                    
                    filtered_result = filtered_result.or(all_cards.public_send("filter_by_#{column}", symbol))
                end
            end

            if filtered_result.size == 0
                return all_cards
            end
            return filtered_result
        end

    end

end