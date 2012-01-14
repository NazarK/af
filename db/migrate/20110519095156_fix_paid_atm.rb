class FixPaidAtm < ActiveRecord::Migration
  def self.up
    remove_column :users, :paid_atm
    add_column :users, :paid_atm, :boolean, :default => false, :null => false
  end

  def self.down
  end
end
