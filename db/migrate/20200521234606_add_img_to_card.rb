class AddImgToCard < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :img, :string
  end
end
