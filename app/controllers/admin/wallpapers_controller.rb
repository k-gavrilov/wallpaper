require 'exiftool'

class Admin::WallpapersController < AdminController
  before_action :set_wallpaper, only: %i[ show edit update destroy ]
  before_action :find_categories, only: %i[ new edit ]

  # GET /admin/wallpapers or /admin/wallpapers.json
  def index
    @wallpapers = Wallpaper.order(:id).page(params[:page])
  end

  # GET /admin/wallpapers/1 or /admin/wallpapers/1.json
  def show
  end

  # GET /admin/wallpapers/new
  def new
    @wallpaper = Wallpaper.new
  end

  # GET /admin/wallpapers/1/edit
  def edit
  end

  # POST /admin/wallpapers or /admin/wallpapers.json
  def create
    category_id = wallpaper_params[:category_id]
    Rails.logger.debug("----WALLPAPER_PARAMS:" + wallpaper_params.inspect)
    Rails.logger.debug("----PICTURES: " + wallpaper_params[:pictures].inspect)
    pictures = wallpaper_params[:pictures].select(&:present?)
    pictures_with_meta = files_hash_with_xmp_meta(pictures, [:object_name, :keywords])
    Rails.logger.debug("----PICTURES_WITH_META: " + pictures_with_meta.inspect)
    @wallpapers = pictures_with_meta.map do |picture_with_meta|
      complete_wallpaper_params = picture_with_meta.merge({category_id: category_id})
      Wallpaper.new(complete_wallpaper_params)
    end
    if @wallpapers.all? { |w| w.valid? }
      Rails.logger.debug("----WE-ARE-IN-VALID")
      @wallpapers.each(&:save!)
      redirect_to admin_wallpapers_path, notice: "Wallpaper was successfully created."
    else
      Rails.logger.debug("-----INVALID--" + @wallpapers.errors.messages.inspect)
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/wallpapers/1 or /admin/wallpapers/1.json
  def update
    if @wallpaper.update(wallpaper_edit_params)
      redirect_to admin_wallpaper_url(@wallpaper), notice: "Wallpaper was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/wallpapers/1 or /admin/wallpapers/1.json
  def destroy
    @wallpaper.destroy!
    redirect_to admin_wallpapers_path, notice: "Wallpaper was successfully destroyed."
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_wallpaper
    @wallpaper = Wallpaper.find(params[:id])
  end

  def find_categories
    @categories = Category.all.order(:name)
  end

  # Only allow a list of trusted parameters through.
  def wallpaper_params
    params.require(:wallpaper).permit(:category_id, pictures: [])
  end

  def wallpaper_edit_params
    params.require(:wallpaper).permit(:category_id, :keywords, :title)
  end

  def files_hash_with_xmp_meta(pictures, meta_keys)
    paths = pictures.map(&:path)
    pictures_with_paths = pictures.map { |picture| {picture: picture, path: picture.path} }
    e = Exiftool.new(paths)
    pictures_with_paths.each_with_object([]) do |picture_with_path, pictures_with_meta|
      meta_hash = e.result_for(picture_with_path[:path]).to_hash
      Rails.logger.debug("-----------------------++++++++META: " + meta_hash.inspect)
      picture_with_meta = {
        picture: picture_with_path[:picture],
        title: meta_hash[:object_name],
        keywords: meta_hash[:keywords]&.join(", ")
      }
      pictures_with_meta << picture_with_meta
    end
  end
end
