class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.decimal :amount
      t.string :currency
      t.integer :user_id

      t.timestamps
    end
  end
end
