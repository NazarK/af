class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :describe, :text
    add_column :users, :city_id, :integer
  end

  def self.down
    remove_column :users, :city_id
    remove_column :users, :describe
  end
end
