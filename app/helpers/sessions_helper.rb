module SessionsHelper

    def log_in(user)
        session[:user_id] = user.id
        if (current_user.shopping_cart.nil? || current_user.shopping_cart.card_count == 0) && session[:cart]
            ShoppingCart.where(user_id: user.id).delete_all
            new_cart = ShoppingCart.create(user_id: user.id)
            session[:cart].each do |card_id|
                Selection.create(shopping_cart_id: new_cart.id, card_id: card_id)
            end
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
        elsif !logged_in?
            @current_user = GuestManager::GuestCart.new
        end
    end

    #Need to implement this later
    def user_admin?
        if (logged_in? && current_user.admin)
            return true
        end
        return false
    end

    #Returns the current shopping cart for the user
    def current_cart
        # Logged in user with a cart
        if logged_in? && current_user.shopping_cart
            return current_user.shopping_cart
        # Logged in user without a cart
        elsif logged_in?
            return ShoppingCart.create(user_id: current_user.id)
        # Guest without a cart
        elsif !session[:cart]
            session[:cart] = []
        end
            
        # Returns guest's cart
        return session[:cart]
        
    end

    def current_cart_path
        if logged_in?
            return current_cart.id
        end
        return "guest"
    end
        


    def log_out
        forget(current_user)
        session.delete(:user_id)
        session.delete(:cart)
    end

end
