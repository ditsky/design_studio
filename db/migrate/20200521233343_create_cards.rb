class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :content
      t.string :card_type
      t.boolean :painted
      t.boolean :hand_cut

      t.timestamps
    end
  end
end
