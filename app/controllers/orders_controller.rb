class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :destroy]
  
    # GET /orders
    # GET /orders.json
    def index
    end
  
    # GET /orders/1
    # GET /orders/1.json
    def show
    end
  
    # GET /orders/new
    def new
      @order = Order.new
      if logged_in?
        @addresses = current_user.addresses
      end
    end
  
    # POST /orders
    # POST /orders.json
    def create
      @order = Order.new(order_params)
  
      respond_to do |format|
        if @order.save
          format.html { redirect_to @order, notice: 'order was successfully created.' }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /orders/1
    # DELETE /orders/1.json
    def destroy
      @order.destroy
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'order was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_order
        @order = Order.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def order_params
        params.require(:order).permit(:amount, :currency, :user_id, :shipping_address_id, :billing_address_id)
      end
  end