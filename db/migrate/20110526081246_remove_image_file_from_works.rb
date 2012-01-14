class RemoveImageFileFromWorks < ActiveRecord::Migration
  def self.up
    remove_column :works, :image_file
    remove_column :works, :image_medium_file
    remove_column :works, :image_thumb_file
  end

  def self.down
  end
end
