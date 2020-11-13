class CardsController < ApplicationController
  include CardsHelper
  before_action :set_card, only: [:show, :edit, :update, :destroy, :delete_image]
  before_action :check_admin, only: [:new, :edit, :create, :update, :destroy]
  # before_action :remove_filter, only: [:index]

  # GET /cards
  # GET /cards.json
  def index
    @params = request.original_fullpath()
    

    # filter_params = {}
    # if params["filters"]
    #   filter_params = params["filters"]
    # end

    # puts filter_params.to_unsafe_h.first
    # remove_filter(@params, filter_params.to_unsafe_h.first[0])
    
    card_filter = FilterManager::CardFilter.new
    valid_filter_columns = [:content, :painted, :hand_cut, :size]

    @cards = Card.all
    @current_filters = {}
    if filter_params
      @current_filters = filter_params[:filters]
      @cards = card_filter.filter(@current_filters, valid_filter_columns)
    end

    puts "\n\n"
    puts filter_params
    puts "\n\n"

    @card_groups = @cards.each_slice(3).to_a
    @card_groups_mobile = @cards.each_slice(2).to_a
    @columns = ["DESIGN", "STYLE", "SHAPE/SIZE"]
    @columns_l = ["Design", "Style", "Shape/Size"]
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)
    respond_to do |format|
      if (params[:card][:display] && @card.save)
        if (params[:card][:images])
          @card.images_s3.attach(params[:card][:images])
        end
        if params[:card][:display]
          @card.display_s3.attach(params[:card][:display])
        end
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        if (params[:card][:images])
          @card.images_s3.attach(params[:card][:images])
        end
        if params[:card][:display]
          @card.display_s3.attach(params[:card][:display])
        end
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  #DELETE /cards/1/delete_image
  def delete_image
    @card.images_s3.where(id: params[:image]).purge
    redirect_to edit_card_path
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    # image_deleter = CardManager::UploadProcessor.new
    # image_deleter.delete(@card.images)
    @card.images_s3.purge
    @card.display_s3.purge
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    def check_admin
      if !user_admin?
        flash[:danger] = "Can not update a card without admin status"
        redirect_back fallback_location: new_card_path
      end
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.permit(:display, :image, images: [])
      params[:card][:content].downcase!
      params[:card][:card_type].downcase!
      params[:card][:size].downcase!
      params.require(:card).permit(:content, :size, :card_type, :price, :painted, :hand_cut, :filter, :short_description, :long_description)
    end

    def filter_params
      params.permit(filters: [])
      if !params["filters"].nil?
        h = params.to_unsafe_h
        params = h.symbolize_keys
        return params.slice(:filters)
      end

      return nil
    end

end
