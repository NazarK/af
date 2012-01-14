class DropSomeTables < ActiveRecord::Migration
  def self.up
    drop_table :cities_import
  end

  def self.down
  end
end
