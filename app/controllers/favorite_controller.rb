require "base64"
class FavoriteController < ApplicationController
  layout "raw", :except => :index
  layout "application", :only => :index

  def self.salt
    3987
  end

  def self.favorites fav_encoded_id
    if @favorite_cached
      @favorite_cached
    end

    favorite_head = Favorite.find_by_id(decode_id(fav_encoded_id))
    if favorite_head
      @favorite_cached = favorite_head.FavoriteUsers
    else
      @favorite_cached = nil
    end
    @favorite_cached
  end

  def self.encode_id(s)
    s = s.to_i
    s = s ^ salt
    while s.to_s.length<4
      s = "0"+s.to_s
    end
    s = Base64.encode64(s.to_s).strip!.gsub("=","")
  end

  def self.decode_id(s)
    if s.nil?
      return ""
    end
    while s.length % 4 != 0
      s = s + "="
    end
    s = Base64.decode64(s).to_i
    s = s ^ salt
    s
  end

  def index

    if params[:id]
      fav_id = FavoriteController::decode_id(params[:id])
      @listHeader = "My favorite architects on Arcfolio"
    else
      if !cookies[:fav_id]
        fav_id = ""
      else
        fav_id = FavoriteController::decode_id(cookies[:fav_id].to_s)
      end 
      @listHeader = "My favorites"
      @share_favorites = cookies[:fav_id]
    end

    @users = []
    if !fav_id || fav_id==""
    else
      fav_list = Favorite.find_by_id(fav_id)
      if fav_list
        @users = fav_list.users
      end
    end
  end

  def add
    #create new favorites
    if !params[:fav_id] || params[:fav_id]==""
    else
      fav_id = FavoriteController::decode_id(params[:fav_id])
      fav_head = Favorite.find_by_id(fav_id);
      if fav_head
        if fav_head.FavoriteUsers.find_all_by_user_id(params[:user_id]).count==0
          fl = FavoriteUser.new
          fl.favorite_id = fav_id
          fl.user_id = params[:user_id]
          fl.save
        end
        @out = Favorite.find_by_id(fav_id).FavoriteUsers.count;
	render "raw"
	return
      end
    end

    fav = Favorite.new
    fav.save
    @out = FavoriteController::encode_id(fav.id)
    fl = FavoriteUser.new
    fl.favorite_id = fav.id
    fl.user_id = params[:user_id]
    fl.save
    render "raw"

  end

  def remove
    fav_id = FavoriteController::decode_id(params[:fav_id])
    fl = Favorite.find_by_id(fav_id).FavoriteUsers.find_by_user_id(params[:user_id])
    if fl 
      fl.delete
    end
    @out = Favorite.find_by_id(fav_id).FavoriteUsers.count;
    render "raw"
  end

end
