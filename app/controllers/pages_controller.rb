class PagesController < ApplicationController
  
  

  def home
    # Show cards based on mom's preference
    @preference = AdminPreference.first
    @homeDesign1 = Card.where(content: @preference.homeDesign1).first(2)
    @homeDesign2 = Card.where(content: @preference.homeDesign2).first(2)
    @homeDesign3 = Card.where(content: @preference.homeDesign3).first(2)
    @homeDesign4 = Card.where(content: @preference.homeDesign4).first(2)
    @cards = [@homeDesign1, @homeDesign2, @homeDesign3, @homeDesign4]
  end


end
