class ShoppingCartsController < ApplicationController
    before_action :set_cart
  
    # GET /carts/1
    def show
      @total = @cart.total
      @cards = @cart.cards.group(:id)
      @sizes = {}
      @cards.each do |card|
        @sizes[card.id] = @cart.cards.where(id: card.id).count
      end
      
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_cart
        @cart = ShoppingCart.find(params[:id])
      end

end
  