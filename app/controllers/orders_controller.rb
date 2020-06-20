class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :destroy]
    skip_before_action :verify_authenticity_token, only: :webhook
  
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
          payment_processor.create_order(payment_intent)
          # Then define and call a method to handle the successful payment intent.
          # handle_payment_intent_succeeded(payment_intent)
        when 'payment_intent.created'
          puts "Intent Created!"
          payment_intent = event.data.object # contains a Stripe::PaymentMethod
          # Then define and call a method to handle the successful attachment of a PaymentMethod.
          # handle_payment_method_attached(payment_method)
        # ... handle other event types
        when 'charge.succeeded'
          puts "Customer Charges Sending Receipt"
          #send receipt email
        else
          # Unexpected event type
          head :bad_request
          return
      end

      head :ok
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