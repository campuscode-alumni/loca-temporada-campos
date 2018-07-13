class RemoveAttributesFromProposals < ActiveRecord::Migration[5.2]
  def change
    remove_column :proposals, :guest_name, :string
    remove_column :proposals, :email, :string
  end
end
