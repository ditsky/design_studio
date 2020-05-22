class RemoveSelections < ActiveRecord::Migration[6.0]
  def change

    drop_table :selections

  end
end
