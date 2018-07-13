class ProposalsController < ApplicationController
  
  def index 
    @proposals = Proposal.all
    if @proposals.empty?
      flash[:alert] = 'Não existem propostas cadastradas'   
    end
  end
end
