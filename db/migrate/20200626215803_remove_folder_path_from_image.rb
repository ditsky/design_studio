class RemoveFolderPathFromImage < ActiveRecord::Migration[6.0]
  def change
    remove_column :images, :folder_path, :string
  end
end
