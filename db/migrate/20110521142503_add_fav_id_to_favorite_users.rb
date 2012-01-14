class AddFavIdToFavoriteUsers < ActiveRecord::Migration
  def self.up
    add_column :favorite_users, :favorite_id, :integer
  end

  def self.down
    remove_column :favorite_users, :favorite_id
  end
end
