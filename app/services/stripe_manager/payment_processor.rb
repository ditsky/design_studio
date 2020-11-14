module StripeManager

    class PaymentProcessor

        def valid?(intent)
            return Order.where(payment_intent: intent.id).size == 0
        end

        def process(intent)
            order = create_order(intent)
            order_id = order.id
            puts "\n\n\n\n\nBefore Cart: " + order.cards.size.to_s + "\n\n\n"
            handle_cart(intent, order)
            order = Order.find(order_id)
            puts "After Cart: " + order.cards.size.to_s
            send_receipts(intent, order)
        end

        def create_order(intent)
            order = Order.create(amount: intent.amount, 
                                currency: intent.currency,
                                user_id: intent.metadata.user_id, 
                                shipping_address_id: intent.metadata.shipping_address_id,
                                billing_address_id: intent.metadata.billing_address_id,
                                payment_intent: intent.id
            )
            return order
        end

        def handle_cart(intent, order)
            shopping_cart = ShoppingCart.find(intent.metadata.shopping_cart_id.to_i)
            shopping_cart.order_selections(order)
            shopping_cart.clear
        end

        def send_receipts(intent, order)
            user = User.find(intent.metadata.user_id)
            puts "Sending Receipt: " + order.cards.size.to_s
            user.send_order_receipt_email(order)
            UserMailer.order_created(order).deliver_now
        end

    end

end