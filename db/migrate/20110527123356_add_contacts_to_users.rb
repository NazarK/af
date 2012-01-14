class AddContactsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :contact_email, :string
    add_column :users, :contact_phone, :string
    add_column :users, :website, :string
  end

  def self.down
    remove_column :users, :website
    remove_column :users, :contact_phone
    remove_column :users, :contact_email
  end
end
