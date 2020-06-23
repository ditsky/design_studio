class AddUserIdToAddress < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string "country"
      t.string "full_name"
      t.string "address_line_1"
      t.string "address_line_2"
      t.string "city"
      t.string "state"
      t.string "zip"
      t.string "phone_number"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.integer "user_id"
    end
  end
end
