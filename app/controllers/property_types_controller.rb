class PropertyTypesController < ApplicationController
  before_action :set_property_type, only: [:show, :edit, :update]
  before_action :authenticate_realtor!, only: [:new, :create, :edit, :update]

  def show; end

  def new
    @property_type = PropertyType.new
  end

  def create
    @property_type = PropertyType.new(property_type_params)
    if @property_type.save
      flash[:success] = t('.success')
      redirect_to @property_type
    else
      flash[:alert] = t('.fail')
      render :new
    end
  end

  def edit; end

  def update
    if @property_type.update(property_type_params)
      flash[:success] = t('.success')
      redirect_to @property_type
    else
      flash[:alert] = t('.fail')
      render :edit
    end
  end

  private

  def property_type_params
    params.require(:property_type).permit(:name)
  end

  def set_property_type
    @property_type = PropertyType.find(params[:id])
  end
end
