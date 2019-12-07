class ClientsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_client, only: [:show]

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(clients_params)
    
    if @client.save
      flash[:notice] = 'Cliente cadastrado com sucesso'
      redirect_to @client
    end

  end

  def show
  end

  private

  def clients_params
    params.require(:client).permit(:name, :document, :email)
  end

  def find_client
    @client = Client.find(params[:id])
  end

end