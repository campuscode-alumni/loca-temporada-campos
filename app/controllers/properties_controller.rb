class PropertiesController < ApplicationController
  before_action :authenticate_realtor!, only: [:new, :create, :edit, :update]
  before_action :set_property, only: [:show, :edit, :update]
  before_action :load_dependencies, only: [:new, :edit]

  def index
    @regions = Region.all
  end
  
  def show; end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    @property.realtor = current_realtor
    if @property.save
      flash[:success] = t('.success')
      redirect_to @property
    else
      flash[:alert] = t('.fail')
      load_dependencies
      render :new
    end
  end

  def edit; end

  def update
    if @property.update(property_params)
      flash[:success] = t('.success')
      redirect_to @property
    else
      load_dependencies
      flash[:alert] = t('.fail')
      render :edit
    end
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:title, :description, :property_type_id,
                                     :region_id, :rent_purpose, :area,
                                     :room_quantity, :accessibility,
                                     :allow_pets, :allow_smokers,
                                     :maximum_guests, :minimum_rent,
                                     :maximum_rent, :daily_rate, :main_photo)
  end

  def load_dependencies
    @regions = Region.all
    @property_types = PropertyType.all
  end

end
