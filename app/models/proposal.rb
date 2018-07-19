class Proposal < ApplicationRecord
  before_save :calcula_valor_total

  belongs_to :property
  belongs_to :user

  validates :start_date, :end_date, :total_guests, :rent_purpose, presence: true

  enum status: [:pending, :approved]

  private

  def calcula_valor_total
    dias = (self.end_date - self.start_date).to_i
    self.total_amount = self.property.daily_rate * dias
  end
end
