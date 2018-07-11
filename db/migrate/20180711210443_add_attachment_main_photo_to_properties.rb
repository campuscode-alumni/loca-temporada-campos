class AddAttachmentMainPhotoToProperties < ActiveRecord::Migration[5.2]
  def self.up
    change_table :properties do |t|
      t.attachment :main_photo
    end
  end

  def self.down
    remove_attachment :properties, :main_photo
  end
end
