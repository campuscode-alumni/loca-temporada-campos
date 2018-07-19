class Proposal < ApplicationRecord
  belongs_to :property
  belongs_to :user

  enum status: [:pending, :approved]
 
  validates :end_date, :start_date, presence: true
  validate :days_rent
  
  private

  def days_rent
    days_result = (end_date - start_date).to_i
    if days_result < property.minimum_rent
      errors.add(:end_date, "Quantidade de dias minima para a locação é de: #{property.minimum_rent}") 
    end
  end
end
