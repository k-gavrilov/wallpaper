class RenameCategoryToCollection < ActiveRecord::Migration[7.1]
  def change
    rename_table :categories, :collections
  end
end
