class AdminPreferencesController < ApplicationController

    def create
        new_preference = AdminPreference.new(preferences_params)
        if new_preference.valid?
          AdminPreference.delete_all
          new_preference.save
          flash[:success] = "Preferences Saved!"
        else
          flash[:danger] = "Invalid Preferences"
        end
        redirect_to root_url
    end

    private

        # Only allow a list of trusted parameters through.
        def preferences_params
            params.require(:admin_preference).permit(:greeting_message, :homeDesign1, :homeDesign2, :homeDesign3, :homeDesign4)
        end

end
