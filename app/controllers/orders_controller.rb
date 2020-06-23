class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :destroy]
    skip_before_action :verify_authenticity_token, only: :webhook
  
    # GET /orders
    # GET /orders.json
    def index
      if logged_in?
        @orders = current_user.orders
      else
        flash[:danger] = "Can not view orders until you are logged in"
        redirect_back fallback_location: root_url
      end
    end
  
    # GET /orders/1
    # GET /orders/1.json
    def show
    end
  
    # GET /orders/new
    def new
      if (!logged_in? || current_cart.card_count == 0)
        flash[:danger] = "Can not proceed to checkout until you are logged in with items in your cart"
        redirect_back fallback_location: shopping_cart_path(current_cart)
      else
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
    end

    def secret
      if Rails.env.production?
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      else
        Stripe.api_key = ENV['STRIPE_SECRET_KEY_DEV']
      end

      #shipping address
      sa = Address.find(params[:order][:shipping_address_id])

      @intent = Stripe::PaymentIntent.create({
        amount: current_cart.total * 100,
        currency: 'usd',
        payment_method_types: ['card'],
        receipt_email: current_user.email,
        metadata: {integration_check: 'accept_a_payment',
                  user_id: params[:order][:user_id],
                  shopping_cart_id: current_cart.id,
                  shipping_address_id: params[:order][:shipping_address_id],
                  billing_address_id: params[:order][:billing_address_id]},
        shipping: {address: {city: sa.city, country: sa.country, 
                            line1: sa.address_line_1,
                            line2: sa.address_line_2,
                            postal_code: sa.zip,
                            state: sa.state},
                   name: sa.full_name}
      })

      #billing address
      ba = Address.find(params[:order][:billing_address_id])

      render :json => {client_secret: @intent.client_secret,
                      name: @intent.shipping.name,
                      email: @intent.receipt_email,
                      billing_address: {city: ba.city, country: ba.country,
                                        line1: ba.address_line_1,
                                        line2: ba.address_line_2,
                                        postal_code: ba.zip,
                                        state: ba.state}}.to_json
      
    end

    


    def webhook
      event = Stripe::Event.retrieve(params[:id])
      # Handle the event
      payment_processor = StripeManager::PaymentProcessor.new
      case event.type
        when 'payment_intent.succeeded' 
          payment_intent = event.data.object # contains a Stripe::PaymentIntent
          puts "Payment Processed!: " + payment_intent.inspect 
          payment_processor.process(payment_intent)
        when 'payment_intent.created'
          payment_intent = event.data.object # contains a Stripe::PaymentIntent
          puts "Intent Created!: " + payment_intent.inspect
        when 'charge.succeeded'
          charge = event.data.object
          puts "Customer Charged: " + charge.inspect    
        when 'charge.refunded'
          charge = event.data.object
          puts "Customer Refunded: " + charge.inspect
        else
          # Unexpected event type
          head :bad_request
          return
      end

      head :ok
    end
  
    
    # DELETE /orders/1
    # DELETE /orders/1.json
    def destroy

      if Rails.env.production?
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      else
        Stripe.api_key = ENV['STRIPE_SECRET_KEY_DEV']
      end

      refund = Stripe::Refund.create({
        payment_intent: @order.payment_intent,
      })
      puts refund.inspect
      @order.destroy
      respond_to do |format|
        format.html { redirect_to orders_url }
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
        params.require(:order).permit(:shipping_address_id)
      end
  end