class ShoppingCartsController < ApplicationController
    before_action :set_cart
  
    # GET /carts/1
    def show
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_cart
        @cart = ShoppingCart.find(params[:id])
      end

end
  