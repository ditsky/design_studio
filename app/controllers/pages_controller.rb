class PagesController < ApplicationController
  
  
  def contact
    @developers = [{:name => "Sam", :email => "sruditsky12@gmail.com"}, 
                    {:name => "Serge", :email => "blahblah@egg.edge"}]

  end

  def home
    @birthday_cards = Card.where(content: "birthday", card_type: "post card").first(2)
    # HACKY hack hack, fix this later
    @sympathy_cards = Card.where(content: "love", card_type: "post card").first(2)
    @thank_you_cards = Card.where(content: "thank you", card_type: "post card").first(2)
    @any_occasion_cards = Card.where(content: "any occasion", card_type: "post card").first(2)
    @cards = [@birthday_cards, @thank_you_cards, @any_occasion_cards, @sympathy_cards]
  end


end
