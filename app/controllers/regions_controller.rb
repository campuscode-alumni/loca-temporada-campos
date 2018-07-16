class RegionsController < ApplicationController
  before_action :set_region, only: [:show, :edit, :update]
  before_action :authenticate_realtor!, only: [:new, :create, :edit, :update]

  def show
    if @region.properties.empty?
      flash[:notice] = t('.notice')
    end
  end

  def new
    @region = Region.new
  end

  def create
    @region = Region.new(region_params)
    if @region.save
      flash[:success] = t('.success')
      redirect_to @region
    else
      flash[:alert] = t('.fail')
      render :new
    end
  end

  def edit; end

  def update
    if @region.update(region_params)
      flash[:success] = t('.success')
      redirect_to @region
    else
      flash[:alert] = t('.fail')
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
