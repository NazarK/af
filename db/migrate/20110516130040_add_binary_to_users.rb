class AddBinaryToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :work_image_file, :binary
    add_column :users, :work_image_medium_file, :binary
    add_column :users, :work_image_thumb_file, :binary
  end

  def self.down
    remove_column :users, :work_image_thumb_file
    remove_column :users, :work_image_medium_file
    remove_column :users, :work_image_file
  end
end
