module SessionsHelper

    def log_in(user)
        session[:user_id] = user.id
        if (current_user.shopping_cart.nil? || current_user.shopping_cart.card_count == 0) && session[:cart]
            ShoppingCart.where(user_id: user.id).delete_all
            ShoppingCart.find(session[:cart]["id"]).update(user_id: user.id)
        end
        session.delete(:cart)
    end

    # Remembers a user in a persistent session.
    def remember(user)
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # Forgets a persistent session.
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    def logged_in?
        !session[:user_id].nil?
    end

    # Returns the user corresponding to the remember token cookie.
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.encrypted[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    def current_user_id
        if logged_in?
            return current_user.id
        end
        return -1
    end

    #Need to implement this later
    def user_admin?
        puts "current_user?: " + current_user
        puts "admin?: " + current_user.admin
        if (current_user && current_user.admin)
            return true
        end
        return false
    end

    #Returns the current shopping cart for the user
    def current_cart
        if logged_in? && current_user.shopping_cart
            return current_user.shopping_cart
        elsif session[:cart].nil? || session[:cart]["id"].nil? || !ShoppingCart.exists?(session[:cart]["id"])
            session[:cart] = ShoppingCart.create
        end
        
        return ShoppingCart.find(session[:cart]["id"])
    end


    def log_out
        forget(current_user)
        session.delete(:user_id)
        session.delete(:cart)
    end

end
