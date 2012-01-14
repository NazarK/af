class User < ActiveRecord::Base
  belongs_to :city
  belongs_to :country
  belongs_to :budget
  has_many :works

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :work_image, :country_id, :city_id, :budget_id, :paid_atm, :describe, :name, :company, :contact_phone, :website, :contact_email

=begin
  has_attached_file :work_image, :storage => :database, :styles => { 
    :medium => { :geometry => "430x130>", :column => 'work_image_medium_file'} , 
    :thumb => { :geometry => "200x140>", :column=>'work_image_thumb_file' }   }
  default_scope select_without_file_columns_for(:work_image)
=end

  def self.listing_salt
     132123
  end

  def listing_url
    url = id ^ self.class.listing_salt
    if !name
      return url.to_s
    end
    url.to_s + "-"+name.downcase.gsub(" ","-")
  end

  def title
    if company
      company
    else
      email
    end
  end
  
  def state_id
    city.state.id if city
  end


  def self.validate user, errors, errorFields
      if user[:company].blank?
        errors.push("Company name can't be blank")
        errorFields[:company] = true
      end      

      if user[:city_id].blank?
        errors.push "Location can't be blank"
	errorFields[:city_id] = true
      end

      if user[:budget_id].blank?
        errors.push "Budget can't be blank"
	errorFields[:budget_id] = true
      end

       if user[:contact_email].blank?
        errors.push("Contact email can't be blank")
        errorFields[:contact_email] = true
      elsif !user[:contact_email].match(/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/)
        errors.push("Contact email is not valid")
	errorFields[:contact_email] = true
      end

      if user[:contact_phone].blank?
        errors.push("Contact phone can't be blank")
	errorFields[:contact_phone] = true
      elsif !user[:contact_phone].match /[0-9+-\.()a-zA-Z]+/
        errors.push("Contact phone is not valid")
	errorFields[:contact_phone] = true
      end
  end

end
