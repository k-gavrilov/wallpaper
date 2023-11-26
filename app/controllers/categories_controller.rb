class CategoriesController < ApplicationController
  skip_before_action :authenticate
  before_action :find_category, only: [:show]
  before_action :find_categories, only: [:show]
  before_action :find_wallpapers, only: [:show]

  def show
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def find_wallpapers
    @wallpapers = Wallpaper.where(category: @category)
  end
end
