class Work < ActiveRecord::Base
  belongs_to :user
=begin
  has_attached_file :image, :storage => :database, :styles => { 
    :medium => { :geometry => "400x280>", :column => 'image_medium_file'} , 
    :thumb => { :geometry => "200x140>", :column=>'image_thumb_file' }   }
  default_scope select_without_file_columns_for(:image)
=end
  has_attached_file :image, 
    :styles => { 
      :medium => { :geometry => "400x400>"} , 
      :thumb => { :geometry => "200x200>" }   },
    :storage => :s3, 
    :bucket => 'arcfolioimages',
    :s3_credentials => {
      :access_key_id => '--put yours--',
      :secret_access_key => '--put yours--'  
    }
  attr_accessible :describe, :image

end
