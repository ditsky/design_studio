class PagesController < ApplicationController
  
  
  def contact
    @developers = [{:name => "Sam", :email => "sruditsky12@gmail.com"}, 
                    {:name => "Serge", :email => "blahblah@egg.edge"}]

  end

  def home
    @birthday_cards = Card.where(content: "birthday").first(2)
    @sympathy_cards = Card.where(content: "sympathy").first(2)
    @thank_you_cards = Card.where(content: "thank you").first(2)
    @blank_cards = Card.where(content: "blank").first(2)
  end


end
