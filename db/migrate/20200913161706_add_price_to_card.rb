class AddPriceToCard < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :price, :float
  end
end
