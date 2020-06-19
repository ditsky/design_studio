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
      @addresses = {}
      if logged_in?
        @addresses = current_user.addresses
      end
      @total = current_cart.cards.size * 5
      @cards = current_cart.cards.group(:id)
      @sizes = {}
      current_cart.cards.each do |card|
        @sizes[card.id] = current_cart.cards.where(id: card.id).count
      end
    end

    def secret
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']

      @intent = Stripe::PaymentIntent.create({
        amount: current_cart.total * 100,
        currency: 'usd',
        payment_method_types: ['card'],
        receipt_email: current_user.email,
        metadata: {integration_check: 'accept_a_payment'},
        shipping: {address: {line1: "18 Cutler Farm Road"},
                   name: current_user.name},
      })

      render :json => {client_secret: @intent.client_secret,
                      name: @intent.shipping.name}.to_json
      
    end
  
    # POST /orders
    # POST /orders.json
    def create
      @order = Order.new(order_params)
  
      respond_to do |format|
        if @order.save
          current_cart.order_selections(@order)
          current_cart.clear
          flash[:success] = "Order Placed!"
          format.html { redirect_to @order }
          format.json { render :show, status: :created, location: @order }
        else
          flash[:danger] = "Order Could Not Be Proccesed"
          format.html { redirect_to new_order_path }
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