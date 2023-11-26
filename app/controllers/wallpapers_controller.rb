class WallpapersController < ApplicationController
  skip_before_action :authenticate
  before_action :find_wallpapers, only: [:index]
  before_action :find_wallpaper, only: [:show]
  before_action :find_categories, only: [:index, :show]

  def index
  end

  def show
  end

  private

  def find_wallpapers
    @wallpapers = Wallpaper.order(:id).page params[:page]
  end

  def find_wallpaper
    @wallpaper = Wallpaper.find(params[:id])
  end
end
