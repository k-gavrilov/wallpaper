class CreateWallpapers < ActiveRecord::Migration[7.1]
  def change
    create_table :wallpapers do |t|
      t.string :category

      t.timestamps
    end
  end
end
