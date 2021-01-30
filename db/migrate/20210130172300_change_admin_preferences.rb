class ChangeAdminPreferences < ActiveRecord::Migration[6.0]
  def change
    change_table :admin_preferences do |t|
      t.change :homeDesign1, :string
      t.change :homeDesign2, :string
      t.change :homeDesign3, :string
      t.change :homeDesign4, :string
    end
  end
end
