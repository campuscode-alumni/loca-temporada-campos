class Property < ApplicationRecord
  belongs_to :property_type
  belongs_to :region
  belongs_to :realtor
  has_many :proposals

  validates :title, :room_quantity, :maximum_guests, :minimum_rent,
            :maximum_rent, :daily_rate,
            presence: true
  validates :main_photo, presence: true
    
  has_attached_file :main_photo
  validates_attachment_content_type :main_photo, content_type: /\Aimage\/.*\z/
end
