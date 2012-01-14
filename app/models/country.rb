class Country < ActiveRecord::Base
  has_many :Cities
  has_many :users
end
