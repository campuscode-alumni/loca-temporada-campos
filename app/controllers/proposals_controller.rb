class ProposalsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create] 
  
  def new
    property_id = params[:property_id]
    @property = Property.find(property_id)
    @proposal = Proposal.new(property: @property)
  end

  def create
    property_id = params[:property_id]
    @property = Property.find(property_id)
    @proposal = @property.proposals.build(params.require(:proposal).permit(:start_date, :end_date, :total_guests, :rent_purpose, :pet, :smoker))
    @proposal.user= current_user
    if @proposal.save
      flash[:notice] = 'Enviado'
    else
      flash[:alert] = 'Erro'
    end
    redirect_to root_path
  end

  def index 
    @proposals = Proposal.all
    if @proposals.empty?
      flash[:alert] = 'Não existem propostas cadastradas'  
      redirect_to root_path
    end
  end
end


