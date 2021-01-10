class ShoppingCartsController < ApplicationController
    before_action :set_cart
  
    # GET /carts/1
    def show
      @sizes = {}
      if logged_in?
        @total = @cart.total
        @cards = @cart.cards.group(:id)
        @id = @cart.id
        @cards.each do |card|
          @sizes[card.id] = @cart.cards.where(id: card.id).count
        end
        @empty = @cart.card_count == 0
      else 
        @total = @guest_helper.total(@cart)
        @cards = @guest_helper.cards(@cart).uniq
        @sizes = @guest_helper.sizes(@cart)
        @id = @guest_helper.id
        @empty = @cart.size == 0
      end

      
    
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_cart
        if logged_in?
          @cart = ShoppingCart.find(params[:id])
        else
          @cart = session[:cart]
          @guest_helper = GuestManager::GuestCart.new
        end
      end

end
  