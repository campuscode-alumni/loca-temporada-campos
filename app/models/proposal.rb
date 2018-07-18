class Proposal < ApplicationRecord
  after_validation :calcula_valor_total
  
  belongs_to :property
  belongs_to :user

  enum status: [:pending, :approved]

  private

  def calcula_valor_total
    dias = (self.end_date - self.start_date).to_i
    self.total_amount = self.property.daily_rate * dias
  end
end
