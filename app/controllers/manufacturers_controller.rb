class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.all
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
  end

  def new
    @manufacturer = Manufacturer.new
  end

    def create
      @manufacturer = Manufacturer.create(manufacturer_params)
      redirect_to @manufacturer 
      #vai avisar o browser para redirecionar, gerando um novo req/resp, não redireciona automaticamente
    end

    private
    
    def manufacturer_params
      params.require(:manufacturer).permit(:name)
    end
end 