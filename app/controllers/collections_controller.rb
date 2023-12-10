class CollectionsController < ApplicationController
  skip_before_action :authenticate
  before_action :find_collection, only: [:show]
  before_action :find_collections, only: [:show]
  before_action :find_wallpapers, only: [:show]

  def show
  end

  private

  def find_collection
    @collection = Collection.find(params[:id])
  end

  def find_wallpapers
    @wallpapers = Wallpaper.where(collection: @collection).page params[:page]
  end
end
