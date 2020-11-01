class Size < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :size, :string, :default => "5x7"
  end
end
