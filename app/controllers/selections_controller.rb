class SelectionsController < ApplicationController
    before_action :set_selection, only: [:destroy]
  
    # POST /selections
    # POST /selections.json
    def create
        @selection = Selection.new(selection_params)

        respond_to do |format|
            if @selection.save
                flash[:success] = "Selection Added to your shopping cart"
                format.html { redirect_back fallback_location: cards_path }
                format.json { head :no_content }
            else
                flash[:failure] = "Could not add this item to your cart"
                format.html { redirect_back fallback_location: cards_path }
                format.json { head :no_content }
            end
        end
    end

    # DELETE /selections/1
    # DELETE /selections/1.json
    def destroy
        @selection.destroy
        respond_to do |format|
          flash[:success] = 'Selection was successfully removed from the cart.'
          format.html { redirect_back fallback_location: root_path}
          format.json { head :no_content }
        end
    end

    # DELETE /selections/remove_card
    # DELETE /selections/remove_card
    def remove_card
      selections = Selection.where(selection_params)
      selections.delete_all
      respond_to do |format|
        flash[:success] = 'Selections were successfully removed from the cart.'
        format.html { redirect_back fallback_location: root_path}
        format.json { head :no_content }
      end
    end


    private

      # Only allow a list of trusted parameters through.
      def selection_params
        params.require(:selection).permit(:shopping_cart_id, :card_id)
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_selection
        @selection = Selection.find(params[:id])
      end

end