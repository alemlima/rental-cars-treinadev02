class ManufacturersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :find_manufacturer, only: [:show, :edit, :update]

  def index
    @manufacturers = Manufacturer.all
  end

  def show
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
      @manufacturer = Manufacturer.new(manufacturer_params)
      
      if @manufacturer.save
        redirect_to @manufacturer
      else
        render :new
      end 
      
  end
  
  def edit
  end

  def update
    
    if @manufacturer.update(manufacturer_params)
      flash[:notice] = 'Fabricante atualizado com sucesso'
      redirect_to @manufacturer
    else
      render :edit
    end
    
  end

    private
    
    def manufacturer_params
      params.require(:manufacturer).permit(:name)
    end

    def find_manufacturer
      @manufacturer = Manufacturer.find(params[:id])
    end
end 