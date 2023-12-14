require 'exiftool'

class Admin::WallpapersController < AdminController
  before_action :set_wallpaper, only: %i[ show edit update destroy ]
  before_action :find_collections, only: %i[ new edit ]

  # GET /admin/wallpapers or /admin/wallpapers.json
  def index
    @wallpapers = Wallpaper.order(created_at: :desc).page(params[:page])
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
    collection_id = wallpaper_params[:collection_id]
    prompt_formula = wallpaper_params[:prompt_formula]
    pictures = wallpaper_params[:pictures].select(&:present?)
    pictures_with_meta = files_hash_with_xmp_meta(pictures, [:object_name, :keywords])
    @wallpapers = pictures_with_meta.map do |picture_with_meta|
      complete_wallpaper_params = picture_with_meta.merge({collection_id: collection_id,
                                                           prompt_formula: prompt_formula})
      Wallpaper.new(complete_wallpaper_params)
    end
    if @wallpapers.all? { |w| w.valid? }
      @wallpapers.each(&:save!)
      redirect_to admin_wallpapers_path, notice: "Wallpaper was successfully created."
    else
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

  def find_collections
    @collections = Collection.all.order(:name)
  end

  # Only allow a list of trusted parameters through.
  def wallpaper_params
    params.require(:wallpaper).permit(:collection_id, :prompt_formula, pictures: [])
  end

  def wallpaper_edit_params
    params.require(:wallpaper).permit(:collection_id, :keywords, :title, :prompt_formula)
  end

  def files_hash_with_xmp_meta(pictures, meta_keys)
    paths = pictures.map(&:path)
    pictures_with_paths = pictures.map { |picture| {picture: picture, path: picture.path} }
    e = Exiftool.new(paths)
    pictures_with_paths.each_with_object([]) do |picture_with_path, pictures_with_meta|
      meta_hash = e.result_for(picture_with_path[:path]).to_hash
      picture_with_meta = {
        picture: picture_with_path[:picture],
        title: meta_hash[:object_name],
        keywords: meta_hash[:keywords]&.join(", ")
      }
      pictures_with_meta << picture_with_meta
    end
  end
end
