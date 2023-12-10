class RedefineCategoryReferenceToCollectionInWallpaper < ActiveRecord::Migration[7.1]
  def up
    rename_column :wallpapers, :category_id, :collection_id
  end

  def down
    rename_column :wallpapers, :collection_id, :category_id
  end
end
