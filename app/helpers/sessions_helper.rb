module SessionsHelper

    def log_in(user)
        session[:user_id] = user.id
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

    #Returns the current shopping cart for the user
    def current_cart
        if logged_in?
            return current_user.shopping_cart.id
        elsif session[:cart].nil? || session[:cart]["id"].nil?
            session[:cart] = ShoppingCart.create
        end
        return session[:cart]["id"]
    end


    def log_out
        forget(current_user)
        session.delete(:user_id)
        session.delete(:cart)
    end

end
