class City < ActiveRecord::Base
  belongs_to :country
  belongs_to :state
  has_many :users
  
  def self.setTop name, value
    c = City.find_by_name(name)
    if c
      c.top = value
      c.save
      return true
    end  
    false
  end

end
