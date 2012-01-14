class UsersController < ApplicationController
  downloads_files_for :user, :work_image

  def listing # /account/listing
    if !current_user
        redirect_to "/users/sign_in"
        return
    end
    
    if params[:user]
      @user = params[:user]
      listing_update
    else
      @errors = []
      @errorFields = {}
      @user = current_user
    end
  end

  def show
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def listing_update
    @user = params[:user]
    @errors = []
    @errorFields = {}

    User::validate @user, @errors, @errorFields
     
    if @errors.count==0
      current_user.update_attributes(params[:user])
      redirect_to "/account"
    else
      @user = current_user
      @user.attributes = params[:user]
    end
    
  end

end
