class AddUserIdToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :user_id, :integer
  end
end
