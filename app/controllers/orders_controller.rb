class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :destroy, :update]
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
      if (current_cart.card_count == 0)
        flash[:danger] = "Can not proceed to checkout until there are items in your cart"
        redirect_back fallback_location: shopping_cart_path(current_cart)
      else
        @order = Order.new
        @addresses = {}
        @user_id = -1
        if logged_in?
          @addresses = current_user.addresses
          @user_id = current_user.id
        end
        @total = current_cart.total
        @cards = current_cart.cards.group(:id)
        @sizes = {}
        current_cart.cards.each do |card|
          @sizes[card.id] = current_cart.cards.where(id: card.id).count
        end

        @publishable_key = ENV['STRIPE_PUBLISHABLE_KEY']
      end

      if !logged_in?
        render 'guest_new'
      end
      
    end

    def secret

      #Check address params
      shipping_address = Address.new
      billing_address = Address.new
      if logged_in?
        shipping_address = Address.find(params[:order][:shipping_address_id])
        billing_address = Address.find(params[:order][:billing_address_id])
      elsif (Truemail.valid?(params[:order][:email], with: :regex))
        shipping_address = Address.new(address_params(:shipping))
        billing_params = address_params(:billing)
        puts "\n\n\n\n\n\n\n\n\n" + billing_params.inspect + "\n\n\n\n\n\n\n\n\n";
        if params[:order][:same_address] == "true"
          billing_address = shipping_address
        else
          billing_address = Address.new(billing_params)
        end

        if (!shipping_address.save || !billing_address.save)
          head :bad_request
          return
        end
      
      end
      

      @intent = Stripe::PaymentIntent.create({
        amount: current_cart.total * 100,
        currency: 'usd',
        payment_method_types: ['card'],
        receipt_email: params[:order][:email],
        metadata: {integration_check: 'accept_a_payment',
                  user_id: params[:order][:user_id],
                  shopping_cart_id: current_cart.id,
                  shipping_address_id: shipping_address.id,
                  billing_address_id: billing_address.id},
        shipping: {address: {city: shipping_address.city, country: shipping_address.country, 
                            line1: shipping_address.address_line_1,
                            line2: shipping_address.address_line_2,
                            postal_code: shipping_address.zip,
                            state: shipping_address.state},
                   name: shipping_address.full_name}
      })



      render :json => {client_secret: @intent.client_secret,
                      name: @intent.shipping.name,
                      email: @intent.receipt_email,
                      billing_address: {city: billing_address.city, country: billing_address.country,
                                        line1: billing_address.address_line_1,
                                        line2: billing_address.address_line_2,
                                        postal_code: billing_address.zip,
                                        state: billing_address.state}}.to_json
      
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
            @order.send_shipping_email()
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

      def set_states
        if !logged_in?
          @states=
          [
            'N/A',
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
  
      # Only allow a list of trusted parameters through.
      def order_params
        params.require(:order).permit(:shipping_address_id, :billing_address_id)
      end

      # Only allow a list of trusted parameters through.
      def address_params(address_type)
        if !logged_in?
          if address_type == :billing
            return params.require(:order).require(:billing).permit(:same, :country, :full_name, :address_line_1, :address_line_2, :city, :state, :zip, :phone_number, :user_id)
          end
          return params.require(:order).require(:shipping).permit(:country, :full_name, :address_line_1, :address_line_2, :city, :state, :zip, :phone_number, :user_id)
        end
      end

      def order_params_admin
        params.require(:order).permit(:status)
      end
  end