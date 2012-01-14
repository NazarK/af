class AddTopToCities < ActiveRecord::Migration
  def self.up
    add_column :cities, :top, :boolean
  end

  def self.down
    remove_column :cities, :top
  end
end
