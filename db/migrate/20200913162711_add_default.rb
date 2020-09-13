class AddDefault < ActiveRecord::Migration[6.0]
  def change

    change_column :cards, :price, :float, :default => 5.00

  end
end
