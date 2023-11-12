class HomeController < ApplicationController
  skip_before_action :authenticate
  before_action :find_wallpapers, only: [:index]

  def index
  end

  private

  def find_wallpapers
    @wallpapers = Wallpaper.all
  end
end
