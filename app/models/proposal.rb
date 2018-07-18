class Proposal < ApplicationRecord
  belongs_to :property
  belongs_to :user

  enum status: [:pending, :approved]
end
