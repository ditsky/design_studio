class CreateAdminPreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_preferences do |t|
      t.integer :homeDesign1
      t.integer :homeDesign2
      t.integer :homeDesign3
      t.integer :homeDesign4
    end
  end
end
