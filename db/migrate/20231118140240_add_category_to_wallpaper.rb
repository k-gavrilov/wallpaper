class AddCategoryToWallpaper < ActiveRecord::Migration[7.1]
  def change
    add_reference :wallpapers, :category, null: false, foreign_key: true
  end
end
