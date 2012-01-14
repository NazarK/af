class AddBudgetToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :budget_id, :integer
  end

  def self.down
    remove_column :users, :budget_id
  end
end
