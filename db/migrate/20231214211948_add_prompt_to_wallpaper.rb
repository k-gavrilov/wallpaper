class AddPromptToWallpaper < ActiveRecord::Migration[7.1]
  def change
    add_column :wallpapers, :prompt_formula, :text
  end
end
