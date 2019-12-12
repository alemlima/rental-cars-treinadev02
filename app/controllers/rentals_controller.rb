class RentalsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_rental, only: [:show, :start]

  def index
    @rentals = Rental.all
  end

  def new
    
    @rental = Rental.new
    @clients = Client.all
    @car_category = CarCategory.all

  end

  def create
    @rental = Rental.new(rental_params)

    if @rental.save
      redirect_to @rental, notice: 'Locação efetuada com sucesso.'
    else
      #erro
      @clients = Client.all
      @car_category = CarCategory.all
      render :new
    end

  end

  def show
    @cars = @rental.car_category.cars
  end

  def start
    @cars = @rental.car_category.cars
    @car = Car.find(params[:rental][:car_id])

    @rental.in_progress!
    @car.rented!
    
    @rental.create_car_rental(car: @car, price: @car.car_category.price)#amarra automaticamente a uma rental e passamos o carro
    
    redirect_to @rental, notice: 'Locação efetivada com sucesso.'
  end

  def search
    
    @rentals = Rental.where('reservation_code like ?', "%#{params[:q]}%")
    render :index
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id, :reservation_code)
  end

  def find_rental
    @rental = Rental.find(params[:id])
  end
end