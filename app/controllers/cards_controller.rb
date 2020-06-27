class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy, :delete_image]
  before_action :check_admin, only: [:new, :edit, :create, :update, :destroy]

  # GET /cards
  # GET /cards.json
  def index
    card_filter = FilterManager::CardFilter.new
    valid_filter_columns = [:content, :painted, :hand_cut, :card_type]
    @cards = card_filter.filter(filter_params(params), valid_filter_columns)
    @card_groups = @cards.each_slice(3).to_a
    @columns = ["CONTENT", "STYLE", "CARD TYPE"]
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

      # if (params[:card][:display] && @card.save)
      #   image_uploader = CardManager::UploadProcessor.new
      #   params[:card][:images] << params[:card][:display]
      #   image_uploader.upload(params[:card][:images], params[:card][:display], @card)
      #   format.html { redirect_to @card, notice: 'Card was successfully created.' }
      #   format.json { render :show, status: :created, location: @card }
      # else
      #   format.html { render :new }
      #   format.json { render json: @card.errors, status: :unprocessable_entity }
      # end
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
      params.require(:card).permit(:content, :card_type, :painted, :hand_cut, :filter, :short_description, :long_description)
    end

    #Allows the filter paramter namespace to be optional in the URL
    def filter_params(params)
      params.slice(:sympathy, :blank, :birthday, :thank_you, :painted, :hand_cut, :fold_over, :post_card)
    end
end
