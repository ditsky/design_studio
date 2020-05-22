class CreateSelections < ActiveRecord::Migration[6.0]
  def change
    create_table :selections do |t|
      t.integer :shopping_cart_id
      t.integer :card_id

      t.timestamps
    end
  end
end
