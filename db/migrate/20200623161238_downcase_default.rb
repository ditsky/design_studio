class DowncaseDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:orders, :status, 'pending')
  end
end
