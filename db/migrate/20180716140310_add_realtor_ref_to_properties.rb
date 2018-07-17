class AddRealtorRefToProperties < ActiveRecord::Migration[5.2]
  def change
    add_reference :properties, :realtor, foreign_key: true
  end
end
