class Admin::CollectionsController < AdminController
  before_action :new_collection, only: [:new]
  before_action :find_collections, only: [:index]

  def index
  end

  def new
  end

  def create
    collection = Collection.new(collection_params)
    if collection.valid?
      collection.save!
      redirect_to admin_collections_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @collection = Collection.find(params[:id])
  end

  def update
    collection = Collection.find(params[:id])
    if collection && collection.update(collection_params)
      collection.save!
      redirect_to admin_collections_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Collection.find(params[:id]).destroy!
    redirect_to admin_collections_path
  end

  private

  def new_collection
    @collection = Collection.new
  end

  def collection_params
    params.require(:collection).permit(:name)
  end

  def find_collections
    @collections = Collection.all
  end
end
