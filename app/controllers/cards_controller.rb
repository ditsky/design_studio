class CardsController < ApplicationController

	#rails db:migrate

#@occasion = "none"

  def birthday
  	@occasion = "birthday"
  end

  def anniversary
  	@occasion = "anniverasry"
  end

  def sympathy
  	@occasion = "sympathy"
  end

  def shop
  	@occasion = "yeetuss"
  end 


end
