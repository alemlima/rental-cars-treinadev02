class CarModelsController < ApplicationController
  
  def index
  
  end

  def new
    @car_model = CarModel.new
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end

  def create
    @car_model = CarModel.new(car_model_params)

    @car_model.save!
    if flash[:notice] = 'Modelo registrado com sucesso.'
      redirect_to @car_model
    else
      @manufacturers = Manufacturer.all
      @car_categories = CarCategory.all
      #erro
      render :new
    end
  end
  
  def show
    @car_model = CarModel.find(params[:id])
  end

  private
  
  def car_model_params
    params.require(:car_model).permit(:name, :year, :motorization, :fuel_type, :car_category_id, :manufacturer_id)
  end

end