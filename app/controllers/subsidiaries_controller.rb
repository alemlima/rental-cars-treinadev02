class SubsidiariesController < ApplicationController

  def index
    @subsidiaries = Subsidiary.all
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.create(subsidiary_params)
    redirect_to @subsidiary
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  private
  
  def subsidiary_params
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end

end