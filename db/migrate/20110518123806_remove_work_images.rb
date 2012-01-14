class RemoveWorkImages < ActiveRecord::Migration
  def self.up
    drop_table :work_images
  end

  def self.down
  end
end
