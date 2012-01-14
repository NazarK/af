class Favorite < ActiveRecord::Base
  has_many :FavoriteUsers
  has_many :users, :through => :FavoriteUsers
end
