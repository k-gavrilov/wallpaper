class RemoveCategoryFromWallpapers < ActiveRecord::Migration[7.1]
  def change
    remove_column :wallpapers, :category, :string
  end
end
