class SessionsController < ApplicationController
  def new
    if params[:redirect] && params[:redirect] == "true"
      session[:email_link] = true
    end
    session[:return_to] = request.referer
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      if user.activated?
        log_in user
        params[:remember_me] == '1' ? remember(user) : forget(user)
        if session[:email_link] == true 
          session.delete(:email_link)
          redirect_to orders_path
        elsif session[:return_to]
          redirect_to session.delete(:return_to)
        else
          redirect_to user
        end
      else
        user.send_activation_email
        message  = "Account not activated. "
        message += "Check your email for a new activation link."   
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def logout
    log_out if logged_in?
    flash[:success] = "Logged out"
    redirect_to root_url
  end
end
