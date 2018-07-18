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
    calcula_valor_total @proposal
    if @proposal.save
      flash[:notice] = 'Proposta enviada com sucesso'
      redirect_to @proposal
    else
      flash[:alert] = 'Erro'
    end
  end

  def index 
    @proposals = Proposal.pending

    if @proposals.empty?
      flash[:alert] = 'Não existem propostas cadastradas' 
    end

  end

  def show
    @logged = current_user || current_realtor
    if @logged
      @proposal = Proposal.find(params[:id])
    else
      redirect_to root_path, alert: "nao autorizado"
    end
  end

  def approve

    @proposal = Proposal.find(params[:id])
    @proposal.approved!
    redirect_to proposals_path, notice: 'Proposta aprovado com sucesso!'

  end

  private

  def calcula_valor_total(proposal)
    dias = (proposal.end_date - proposal.start_date).to_i
    proposal.total_amount = proposal.property.daily_rate * dias
  end

end


