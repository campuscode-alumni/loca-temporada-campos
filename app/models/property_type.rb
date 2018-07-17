class PropertyType < ApplicationRecord
  has_many :properties

  validates :name, presence: true
end
