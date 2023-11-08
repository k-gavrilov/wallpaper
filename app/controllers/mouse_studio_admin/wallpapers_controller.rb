class MouseStudioAdmin::WallpapersController < ApplicationController
  before_action :set_wallpaper, only: %i[ show edit update destroy ]

  # GET /mouse_studio_admin/wallpapers or /mouse_studio_admin/wallpapers.json
  def index
    @wallpapers = Wallpaper.all
  end

  # GET /mouse_studio_admin/wallpapers/1 or /mouse_studio_admin/wallpapers/1.json
  def show
  end

  # GET /mouse_studio_admin/wallpapers/new
  def new
    @wallpaper = Wallpaper.new
  end

  # GET /mouse_studio_admin/wallpapers/1/edit
  def edit
  end

  # POST /mouse_studio_admin/wallpapers or /mouse_studio_admin/wallpapers.json
  def create
    @wallpaper = Wallpaper.new(wallpaper_params)

    respond_to do |format|
      if @wallpaper.save
        format.html { redirect_to mouse_studio_admin_wallpaper_url(@wallpaper), notice: "Wallpaper was successfully created." }
        format.json { render :show, status: :created, location: @wallpaper }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wallpaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mouse_studio_admin/wallpapers/1 or /mouse_studio_admin/wallpapers/1.json
  def update
    respond_to do |format|
      if @wallpaper.update(wallpaper_params)
        format.html { redirect_to mouse_studio_admin_wallpaper_url(@wallpaper), notice: "Wallpaper was successfully updated." }
        format.json { render :show, status: :ok, location: @wallpaper }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wallpaper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mouse_studio_admin/wallpapers/1 or /mouse_studio_admin/wallpapers/1.json
  def destroy
    @wallpaper.destroy!

    respond_to do |format|
      format.html { redirect_to mouse_studio_admin_wallpapers_path, notice: "Wallpaper was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallpaper
      @wallpaper = Wallpaper.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallpaper_params
      params.require(:wallpaper).permit(:category, :picture)
    end
end
