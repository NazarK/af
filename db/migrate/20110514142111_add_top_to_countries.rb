class AddTopToCountries < ActiveRecord::Migration
  def self.up
    add_column :countries, :top, :integer
  end

  def self.down
    remove_column :countries, :top
  end
end
