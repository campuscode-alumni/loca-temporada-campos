class Proposal < ApplicationRecord
  before_save :calcula_valor_total

  belongs_to :property
  belongs_to :user

  validates :start_date, :end_date, :total_guests, :rent_purpose, presence: true

  enum status: [:pending, :approved]
 
  validate :days_rent, :valid_smoker, :valid_pet
  
  private

  def valid_pet
    if pet && !property.allow_pets 
      errors.add(:smoker, "Nesta propriedade não é permitido a presença de animais!")
    end
  end

  def valid_smoker
    if smoker && !property.allow_smokers 
      errors.add(:smoker, "Nesta propriedade não é permitido a presença de fumantes!")
    end
  end

  def days_rent
   end_date && start_date && calc_days_rent
  end

  def calcula_valor_total
    dias = (self.end_date - self.start_date).to_i
    self.total_amount = self.property.daily_rate * dias
  end

  def calc_days_rent
    days_result = (end_date - start_date).to_i
    if days_result < property.minimum_rent
      errors.add(:end_date, "Quantidade de dias minima para a locação é de: #{property.minimum_rent}") 
    end
  end

end


