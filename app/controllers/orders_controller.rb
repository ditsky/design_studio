class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :destroy, :update]
    before_action :set_cart_size, only: [:new]
    before_action :set_states, only: [:new]
    skip_before_action :verify_authenticity_token, only: :webhook

    if Rails.env.production?
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    else
      Stripe.api_key = ENV['STRIPE_SECRET_KEY_DEV']
    end
  
    # GET /orders
    # GET /orders.json
    def index
      if logged_in?
        if user_admin?
          @orders = Order.all
          @admin = true
          @options = ["pending", "in process", "shipping", "DELETE"]
        else
          @orders = current_user.orders
          @admin = false
        end
        if params[:status]
          @orders = @orders.where(status: params[:status])
        end
      else
        flash[:danger] = "Can not view orders until you are logged in"
        redirect_back fallback_location: root_url
      end
    end
  
    # GET /orders/new
    def new
      if (@cart_size < 1)
        flash[:danger] = "Can not proceed to checkout until you have items in your cart"
        redirect_back fallback_location: shopping_cart_path(current_cart)
      else
        @order = Order.new
        @sizes = {}
        if logged_in?
          @addresses = current_user.addresses
          @total = current_cart.total
          @cards = current_cart.cards.group(:id)
          current_cart.cards.each do |card|
            @sizes[card.id] = current_cart.cards.where(id: card.id).count
          end
        else
          @address = Address.new
          @total = @guest_helper.total(current_cart)
          @cards = @guest_helper.cards(current_cart)
          @sizes = @guest_helper.sizes(current_cart)
          render 'guest_new'
        end

        @publishable_key = ENV['STRIPE_PUBLISHABLE_KEY']
      end
    end

    def secret

      #shipping address
      sa = Address.find(params[:order][:shipping_address_id])

      @intent = Stripe::PaymentIntent.create({
        amount: current_cart.total * 100,
        currency: 'usd',
        payment_method_types: ['card'],
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
          if payment_processor.valid?(payment_intent)
            payment_processor.process(payment_intent)
          end
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

    # PATCH/PUT /orders/1
    # PATCH/PUT /orders/1.json
    def update
      respond_to do |format|
        
        previous_status = @order.status
        updated = false
        if (logged_in? && user_admin?)
          updated = @order.update(order_params_admin)
        elsif (logged_in?)
          updated = @order.update(order_params)
        end
        
        if updated
          if @order.status == "shipping" && previous_status != "shipping"
            @order.send_shipping_email
          end

          if @order.status == "DELETE"
            @order.delete
          end
          
          flash[:success] = "Order Successfully Updated"
          format.html { redirect_to orders_path }
          format.json { render :index, status: :ok, location: orders_path }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  
    
    # DELETE /orders/1
    # DELETE /orders/1.json
    def destroy

      refund = Stripe::Refund.create({
        payment_intent: @order.payment_intent,
      })
      puts refund.inspect

      if refund.status == "succeeded"
        @order.destroy
        respond_to do |format|
          flash[:success] = "Your order has been refunded"
          format.html { redirect_to orders_url }
          format.json { head :no_content }
        end
      else
        flash[:alert] = "There was An Error Refunding Your Charge"
        redirect_back fallback_location: orders_path
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_order
        @order = Order.find(params[:id])
      end

      def set_cart_size
        if logged_in?
          @cart_size = current_cart.card_count
        else
          @cart_size = session[:cart].size
          @guest_helper = GuestManager::GuestCart.new
        end
      end
  
      # Only allow a list of trusted parameters through.
      def order_params
        params.require(:order).permit(:shipping_address_id)
      end

      def order_params_admin
        params.require(:order).permit(:status)
      end

      def set_states
        if !logged_in?
          @states=
          [
            'AK',
            'AL',
            'AR',
            'AZ',
            'CA',
            'CO',
            'CT',
            'DC',
            'DE',
            'FL',
            'GA',
            'HI',
            'IA',
            'ID',
            'IL',
            'IN',
            'KS',
            'KY',
            'LA',
            'MA',
            'MD',
            'ME',
            'MI',
            'MN',
            'MO',
            'MS',
            'MT',
            'NC',
            'ND',
            'NE',
            'NH',
            'NJ',
            'NM',
            'NV',
            'NY',
            'OH',
            'OK',
            'OR',
            'PA',
            'RI',
            'SC',
            'SD',
            'TN',
            'TX',
            'UT',
            'VA',
            'VT',
            'WA',
            'WI',
            'WV',
            'WY'
          ]
        end
      end
  end