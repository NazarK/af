class AddThumbsToImage < ActiveRecord::Migration
  def self.up
    add_column :images, :image_medium_file, :binary
    add_column :images, :image_thumb_file, :binary
  end

  def self.down
    remove_column :images, :image_thumb_file
    remove_column :images, :image_medium_file
  end
end
