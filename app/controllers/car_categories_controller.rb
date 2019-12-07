class CarCategoriesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_car_category, only: [:show, :edit, :update]

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
  end

  def edit
  end

  def update
    if @car_category.update(car_category_params)
      flash[:notice] = 'Categoria atualizada com sucesso.'
      redirect_to @car_category
    end

  end

  private
  def car_category_params
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end

  def find_car_category
    @car_category = CarCategory.find(params[:id])
  end


end
