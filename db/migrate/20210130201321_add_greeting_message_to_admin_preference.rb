class AddGreetingMessageToAdminPreference < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_preferences, :greeting_message, :string
  end
end
