class AddUrlToBudget < ActiveRecord::Migration
  def self.up
    add_column :budgets, :url, :string
  end

  def self.down
    remove_column :budgets, :url
  end
end
