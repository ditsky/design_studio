class SelectionsController < ApplicationController
  
    # POST /selections
    # POST /selections.json
    def create
        @selection = Selection.new(selection_params)
        respond_to do |format|
          if logged_in? && @selection.valid?
              @selection.save
          elsif !logged_in?
            session[:cart] << @selection.card_id
          else
            flash[:danger] = "Could not add this item to your cart"
            format.html { redirect_back fallback_location: cards_path }
            format.json { head :no_content }
          end

          # Success!
          if params["flash"] && params["flash"] == "1"
            flash[:success] = "Item added to your cart"
          end
          format.html { redirect_back fallback_location: cards_path }
          format.json { head :no_content }
        end
    end

    # DELETE /selections/1
    # DELETE /selections/1.json
    def destroy
        if logged_in?
          @selection = Selection.find(params[:id])
          @selection.destroy
        else
          session[:cart].delete_at(session[:cart].index(params["id"].to_i))
        end

        respond_to do |format|
          format.html { redirect_back fallback_location: root_path}
          format.json { head :no_content }
        end
    end

    # DELETE /selections/remove_card
    # DELETE /selections/remove_card
    def remove_card
      if logged_in?
        selections = Selection.where(selection_params)
        selections.delete_all
      else 
        puts selection_params["card_id"].inspect
        puts session[:cart].inspect
        session[:cart].delete(selection_params["card_id"].to_i)
      end
      respond_to do |format|
        flash[:success] = 'Selections were successfully removed from the cart.'
        format.html { redirect_back fallback_location: root_path}
        format.json { head :no_content }
      end
    end


    private

      # Only allow a list of trusted parameters through.
      def selection_params
        params.require(:selection).permit(:shopping_cart_id, :card_id, :order_id)
      end

end