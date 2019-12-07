class CarsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_cars, only: [:show]

  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      flash[:notice] = 'Carro cadastrado com sucesso.'
      redirect_to @car
    else
      #erro
      @car_models = CarModel.all
      @subsidiaries = Subsidiary.all
      render :new
    end
  end

  def show
  end

  private

  def car_params
    params.require(:car).permit(:license_plate, :color, :mileage, :car_model_id, :subsidiary_id )
  end

  def find_cars
    @car = Car.find(params[:id])
  end

end