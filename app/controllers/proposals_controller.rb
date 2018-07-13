class ProposalsController < ApplicationController
  
  before_action :authenticate_user!
  
  def new
    property_id = params[:property_id]
    @property = Property.find(property_id)
    @proposal = Proposal.new(property: @property)
  end

  def create
    property_id = params[:property_id]
    @property = Property.find(property_id)
    @proposal = @property.proposals.build(params.require(:proposal).permit(:start_date, :end_date, :total_guests, :rent_purpose, :pet, :smoker))
    
    if @proposal.save
      flash[:notice] = 'Enviado'
    else
      flash[:alert] = 'Erro'
    end
    redirect_to root_path
  end
end