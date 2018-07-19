class ProposalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_realtor_or_user, only: [:show, :index]
  
  def new
    property_id = params[:property_id]
    @property = Property.find(property_id)
    @proposal = Proposal.new(property: @property)
  end

  def create
    property_id = params[:property_id]
    @property = Property.find(property_id)
    @proposal = @property.proposals.build(params.require(:proposal).permit(:start_date, :end_date, :total_guests, :rent_purpose, :pet, :smoker))
    @proposal.user = current_user

    if @proposal.save
      flash[:notice] = 'Proposta enviada com sucesso'
      redirect_to @proposal
    else
      flash[:alert] = I18n.t 'validate.error'
      render :new
    end
  end

  def index 
    if user_signed_in?
      @index_title = "Propostas enviadas"
      @proposals = Proposal.where(user: current_user)
    elsif realtor_signed_in?
      @index_title = "Propostas pendentes"
      @proposals = Proposal.pending
    end
    if @proposals.empty?
      flash[:alert] = 'Não existem propostas cadastradas' 
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def approve
    @proposal = Proposal.find(params[:id])
    @proposal.approved!
    redirect_to proposals_path, notice: 'Proposta aprovado com sucesso!'
  end

  private

  def authenticate_realtor_or_user
    unless user_signed_in? or realtor_signed_in?
      redirect_to root_path, alert: "nao autorizado"
    end
  end
end


