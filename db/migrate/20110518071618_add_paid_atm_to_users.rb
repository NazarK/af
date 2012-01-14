class AddPaidAtmToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :paid_atm, :boolean
  end

  def self.down
    remove_column :users, :paid_atm
  end
end
