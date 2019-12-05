class RentalsController < ApplicationController

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
      flash[:alert] = 'Locação efetuada com sucesso.'
      redirect_to @rental
    else
      #erro
      @clients = Client.all
      @car_category = CarCategory.all
      render :new
    end

  end

  def show
  
    @rental = Rental.find(params[:id])

  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id)
  end
end