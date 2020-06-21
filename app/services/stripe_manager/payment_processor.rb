module StripeManager

    class PaymentProcessor

        def process(intent)
            order = create_order(intent)
            handle_cart(intent, order)
            send_receipt(intent, order)
        end

        def create_order(intent)
            order = Order.create(amount: intent.amount, 
                                currency: intent.currency,
                                user_id: intent.metadata.user_id, 
                                shipping_address_id: intent.metadata.shipping_address_id,
                                billing_address_id: intent.metadata.billing_address_id
            )
            return order
        end

        def handle_cart(intent, order)
            shopping_cart = ShoppingCart.find(intent.metadata.shopping_cart_id.to_i)
            shopping_cart.order_selections(order)
            shopping_cart.clear
        end

        def send_receipt(intent, order)
            user = User.find(intent.metadata.user_id)
            user.send_order_receipt_email(order)
        end

    end

end