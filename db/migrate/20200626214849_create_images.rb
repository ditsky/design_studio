class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :folder_path
      t.string :filename
      t.integer :card_id

      t.timestamps
    end
  end
end
