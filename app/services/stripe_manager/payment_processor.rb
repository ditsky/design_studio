module StripeManager

    class PaymentProcessor

        def create_order(intent)
            
            
            order = Order.create(amount: intent.amount, 
                                currency: intent.currency,
                                user_id: intent.metadata.user_id, 
                                shipping_address_id: intent.metadata.shipping_address_id,
                                billing_address_id: intent.metadata.billing_address_id
            )
            shopping_cart = ShoppingCart.find(intent.metadata.shopping_cart_id.to_i)
            shopping_cart.order_selections(order)
            shopping_cart.clear
        end

    end

end