class Admin::CategoriesController < AdminController
  before_action :new_category, only: [:new]
  before_action :find_categories, only: [:index]

  def index
  end

  def new
  end

  def create
    category = Category.new(category_params)
    if category.valid?
      category.save!
      redirect_to admin_categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    category = Category.find(params[:id])
    if category && category.update(category_params)
      category.save!
      redirect_to admin_categories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Category.find(params[:id]).destroy!
    redirect_to admin_categories_path
  end

  private

  def new_category
    @category = Category.new
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def find_categories
    @categories = Category.all
  end
end
