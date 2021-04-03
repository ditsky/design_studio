module StripeManager

    class PaymentProcessor

        def valid?(intent)
            puts "CHECKING VALIDITY"
            if ShoppingCart.exists?(intent.metadata.shopping_cart_id.to_i)
                shopping_cart = ShoppingCart.find(intent.metadata.shopping_cart_id.to_i)
                cart_empty = shopping_cart.empty?
                valid_price = shopping_cart.total == intent.amount/100
                duplicate_order = Order.where(payment_intent: intent.id).size != 0
                return !cart_empty && !duplicate_order && valid_price
            end

            return false
        end

        def process(intent)
            order = create_order(intent)
            order_id = order.id
            handle_cart(intent, order)
            order = Order.find(order_id)
            send_receipts(intent, order)
        end

        def create_order(intent)
            order = Order.create(amount: intent.amount, 
                                currency: intent.currency,
                                user_id: intent.metadata.user_id, 
                                email: intent.receipt_email,
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
            puts "Sending Receipts for a $: " + (order.amount / 100).to_s + " order "
            order.send_receipt(intent.receipt_email, intent.shipping.name, order)
            UserMailer.order_created(intent.receipt_email, intent.shipping.name, order).deliver_now
        end

    end

end