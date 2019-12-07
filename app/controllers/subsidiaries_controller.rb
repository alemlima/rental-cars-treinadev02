class SubsidiariesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_subsidiary, only: [:show, :edit, :update, :destroy]
  
  def index
    @subsidiaries = Subsidiary.all
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def show
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
   if @subsidiary.save
     redirect_to @subsidiary
   else
     render :new
   end
  end

  def edit
  end

  def update
    if @subsidiary.update(subsidiary_params)
      flash[:notice] = 'Filial atualizada com sucesso.'
      redirect_to @subsidiary
    else
      render :edit
    end

  end

  def destroy
    if @subsidiary.destroy
      flash[:notice] = 'Filial excluída com sucesso.'
      redirect_to subsidiaries_path
    end
  end

  private
  
  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end

  def find_subsidiary
    @subsidiary = Subsidiary.find(params[:id])
  end

end