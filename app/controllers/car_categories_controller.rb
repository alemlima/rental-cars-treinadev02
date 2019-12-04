class CarCategoriesController < ApplicationController

  def index
    @car_categories = CarCategory.all
  end

  def new
    @car_category = CarCategory.new
  end

  def create
    @car_category = CarCategory.create(car_category_params)
    redirect_to @car_category
  end

  def show
    @car_category = CarCategory.find(params[:id])
  end

  def edit
    @car_category = CarCategory.find(params[:id])
  end

  def update
    @car_category = CarCategory.find(params[:id])

    if @car_category.update(car_category_params)
      flash[:notice] = 'Categoria atualizada com sucesso.'
      redirect_to @car_category
    end

  end

  private
  def car_category_params
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end
end
