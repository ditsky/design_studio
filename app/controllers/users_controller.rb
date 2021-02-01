class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @orders = current_user.orders.last(3)
    @sizes = {}
    @overflow = {}
    @orders.each do |order|
      @sizes[order.id] = {}
      order.cards.each do |card|
        @sizes[order.id][card.id] = order.card_count(card.id)
      end
      @overflow[order.id] = order.cards.count - 2
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if (!logged_in? || @user != current_user)
      flash[:danger] = "You must be logged into an account to edit it"
      redirect_back fallback_location: root_url
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.admin = false #Make sure no one is trying to grant themselves admin powers
    respond_to do |format|
      if @user.save
        ShoppingCart.create(user_id: @user.id)
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /mail
  def mail_newsletter
    if user_admin?
      UserMailer.newsletter(params[:email_body]).deliver_now
      redirect_to current_user
    else
      flash[:danger] = "Go away hackermen"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
