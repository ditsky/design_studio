class AddOrderIdToCard < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :order_id, :integer
  end
end
