module GuestManager

    class GuestCart

        def id
            return "guest"
        end


        def total(cart)
            total = 0
            cart.each do |card_id|
                total += Card.find(card_id).price
            end
            return total
        end

        def cards(cart)
            card_models = []
                cart.each do |card_id|
                    card_models << Card.find(card_id)
                end
            return card_models
        end

        def sizes(cart)
            return cart.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
        end

    end

end