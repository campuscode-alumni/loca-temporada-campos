class RegionsController < ApplicationController
  before_action :set_region, only: [:show, :edit, :update]
  before_action :authenticate_realtor!, only: [:edit, :update]

  def show
    if @region.properties.empty?
      flash[:error] = 'Nenhum imovel para esta região'
    end
  end

  def new
    @region = Region.new
  end

  def create
    @region = Region.new(region_params)
    if @region.save
      flash[:success] = 'Região cadastrada com sucesso'
      redirect_to @region
    else
      flash[:alert] = 'Você deve preencher todos os campos'
      render :new
    end
  end

  def edit
    @region
  end

  def update
    if @region.update(region_params)
      redirect_to @region
    else
      flash[:alert] = 'Você deve preencher todos os campos'
      render :edit
    end
  end

  private

  def region_params
    params.require(:region).permit(:name)
  end

  def set_region
    @region = Region.find(params[:id])
  end
end
