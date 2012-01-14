require 'spec_helper'

describe FavoriteController do
  render_views
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'add'" do
    it "should be successful" do
      get 'add', {:fav_id=>'', :user_id=>1}
      fav_id = response.body
      f = Favorite.find_by_id(FavoriteController::decode_id(fav_id))
      
      f.FavoriteUsers.count.should eql(1)

      response.should be_success
    end
  end

  describe "GET 'remove'" do
    it "should be successful" do 
      fav = Favorite.new
      fav.save
      fav_id = fav.id
      fl = FavoriteUser.new
      fl.favorite_id = fav_id
      fl.user_id = 10
      fl.save
      
      Favorite.find_by_id(fav_id).FavoriteUsers.count.should eql(1)
      get 'remove', {:fav_id=>FavoriteController::encode_id(fav_id), :user_id=>10}
      Favorite.find_by_id(fav_id).FavoriteUsers.count.should eql(0)
      response.should be_success
    end
  end

end
