class AddStatusToProposal < ActiveRecord::Migration[5.2]
  def change
    add_column :proposals, :status, :integer
  end
end
