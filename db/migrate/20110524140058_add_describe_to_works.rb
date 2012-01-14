class AddDescribeToWorks < ActiveRecord::Migration
  def self.up
    add_column :works, :describe, :string
  end

  def self.down
    remove_column :works, :describe
  end
end
