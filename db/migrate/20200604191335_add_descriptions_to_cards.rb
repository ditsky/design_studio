class AddDescriptionsToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :short_description, :string
    add_column :cards, :long_description, :string
  end
end
