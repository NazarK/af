require "spec_helper"

describe PageController do 

  render_views
  describe "getCountryBudget" do 
    it 'should be successful' do 
      budget = Budget.first
      get 'catalog', {:location => 'united-states', :budget => budget.url}
      response.should have_selector('span', :class => 'budget', :content => budget.name)
      response.should have_selector('span', :class => 'location', :content => 'United States')
      response.should be_success
    end
  end

  describe "getCityBudget" do 
    it 'should be successful' do 
      budget = Budget.first
      get 'catalog', {:location => 'chicago', :budget => budget.url}
      response.should have_selector('span', :class => 'budget', :content => budget.name)
      response.should have_selector('span', :class => 'location', :content => 'Chicago')
      response.should be_success
    end
  end

  describe "getBudget" do 
    it 'should be successful' do 
      budget = Budget.first
      get 'catalog', {:location => budget.url}
      response.should have_selector('span', :class => 'budget', :content => budget.name)
      response.should be_success
    end
  end

  describe "getCountry" do 
    it 'should be successful' do 
      get 'catalog', {:location => 'united-states'}
      response.should have_selector('span', :class => 'budget', :content => 'Any budget')
      response.should have_selector('span', :class => 'location', :content => 'United States')
      response.should be_success
    end
  end

  describe "getCity" do 
    it 'should be successful' do 
      get 'catalog', {:location => 'chicago'}
      response.should have_selector('span', :class => 'budget', :content => 'Any budget')
      response.should have_selector('span', :class => 'location', :content => 'Chicago')
      response.should be_success
    end
  end

  describe "getAll" do 
    it 'should be successfull' do 
      get 'catalog'
      response.should have_selector('span', :class => 'budget', :content => 'Any budget')
      response.should have_selector('span', :class => 'location', :content => 'Any City')
      response.should be_success
    end
  end

end