class AddUrlToCountries < ActiveRecord::Migration
  def self.up
    add_column :countries, :url, :string
  end

  def self.down
    remove_column :countries, :url
  end
end
