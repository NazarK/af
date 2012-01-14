require "pp"
class PageController < ApplicationController
  layout :compute_layout
  
  
  def compute_layout
    if action_name == 'country_cities' || action_name == 'image_upload' || action_name == 'state_cities'
      return "raw"
    end
    
    if action_name == 'listing_print'
      return "print"
    end
    "application"
  end

  def home
    
  end

  #used in listing all cities
  def cities
    @topCities = City.includes(:country).where("cities.top='t'").order("cities.name")
    @topCountries = Country.where("name='United States'").order("top desc")
  end

  def country_cities
    @cities = City.order("name").find_all_by_country_id(params[:country_id])
  end

  def state_cities
    @cities = State.find_by_id(params[:state_id]).cities.order("name")
    render "country_cities"
  end


  #used in catalog rendering
  def by_country
    name = params[:name]
    @country = Country.where(:url => name).first
    if !@country
      return false
    end
    where = "cities.country_id=#{@country.id}"
    if @budget
      where = where + " AND budget_id=#{@budget.id}"
    end
    @users = User.order("paid_atm desc").joins(:city).where(where).all
    @location = @country
    render "user_cards"
  end

  def by_state #us only
    name = params[:name]
    @state = State.where(:url => name).first
    if !@state
      return false
    end
    where = ""
    if @budget
      where = "budget_id=#{@budget.id}"
    end
    @users = @state.users.order("paid_atm desc").where(where).all
    @location = @state
    render "user_cards"
  end

  def by_city
    name = params[:name]
    @city = City.find_by_url(name)
    if !@city
       return false
    end

    where = "city_id=#{@city.id}"
    if @budget
       where = where + " AND budget_id=#{@budget.id}"
    end

    @users = User.order("paid_atm desc").where(where)
    @location = @city
    render "user_cards"
  end

  def show_all
    @users = User.order("paid_atm desc")
    render "user_cards"
  end

  def by_budget
    budget = params[:location]
    @budget = Budget.find_by_url(budget)
    if @budget
      @users = User.order("paid_atm desc").find_all_by_budget_id(@budget.id)
      render "user_cards"
      return true
    end
    return false
  end

  def catalog
    if !params[:location]
      show_all
    else
      if !by_budget #case when first parameter is budget
	
	if params[:budget]
          @budget = Budget.find_by_url(params[:budget])
	end

        params[:name] = params[:location]
	by_state || by_city || by_country
      end
    end
  end

  def about
  end

  def account
   if !current_user
      redirect_to "/users/sign_in"
      return
   end
   @user = current_user
  end

  def listing
    id = params[:id].split("-").first
    id = id.to_i ^ User::listing_salt
    @user = User::find_by_id(id)
  end
  
  def listing_print
    listing
    render :listing    
  end

  def signup
    puts "session"
    pp session
    @errors = []
    @errorFields = {}
    if params[:submit]
      user = params[:user]

      
      if session[:work_id].blank?
        @errors.push "Add a portfolio image"
	@errorFields[:image] = true
      end

      User::validate user, @errors, @errorFields
      session[:user] = user

      if @errors.count==0
        redirect_to "/signup/upgrade"
      end
    end
  end

  def image_upload
    if params[:work]
      if session[:work_id].blank?
        @work = Work.new
	@work.save
	session[:work_id] = @work.id
      else
        @work = Work.find_by_id(session[:work_id])
      end
      @work.update_attributes(params[:work])
    end
  end

  def signup_upgrade
    
  end

  def signup_publish
    if params[:upgrade]
      redirect_to "/users/sign_up", :upgrade => 1
    else
      redirect_to "/users/sign_up"
    end
  end

  def account_created
    puts "printing session"
    pp session
    if session[:user]
      puts "current user"
      pp current_user
      puts "starting update"
      user = session[:user]
      user.delete(:state_id)
      u = User.find_by_id(current_user.id)
      u.update_attributes(user)
      u.save
      w = Work.find_by_id(session[:work_id])
      w.user_id = u.id
      w.describe = user[:work_describe]
      w.save
      puts "new user attributes updated from session"
    end
    current_user.save
    redirect_to "/account"
  end

  def test
    render :text => 'test'
  end
end
