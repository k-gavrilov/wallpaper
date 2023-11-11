class AddTitleKeywordsToWallpaper < ActiveRecord::Migration[7.1]
  def change
    add_column :wallpapers, :title, :string
    add_column :wallpapers, :keywords, :text
  end
end
