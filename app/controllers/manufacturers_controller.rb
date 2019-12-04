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
      @manufacturer = Manufacturer.new(manufacturer_params)
      
      if @manufacturer.save
        redirect_to @manufacturer
      else
        #flash.now[:alert] = 'Todos os campos devem sem preenchidos'
        render :new
      end 
      #vai avisar o browser para redirecionar, gerando um novo req/resp, não redireciona automaticamente
  end
  
  def edit
    @manufacturer = Manufacturer.find(params[:id])
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    
    if @manufacturer.update(manufacturer_params)
      flash[:notice] = 'Fabricante atualizado com sucesso'
      redirect_to @manufacturer
    else
      #flash.now[:alert] = 'Não foi possível atualizar o fabricante'
      render :edit
    end
    
  end

    private
    
    def manufacturer_params
      params.require(:manufacturer).permit(:name)
    end
end 