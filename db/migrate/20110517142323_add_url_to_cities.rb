class AddUrlToCities < ActiveRecord::Migration
  def self.up
    add_column :cities, :url, :string
  end

  def self.down
    remove_column :cities, :url
  end
end
