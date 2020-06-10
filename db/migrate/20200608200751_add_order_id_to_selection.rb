class AddOrderIdToSelection < ActiveRecord::Migration[6.0]
  def change
    add_column :selections, :order_id, :integer
  end
end
